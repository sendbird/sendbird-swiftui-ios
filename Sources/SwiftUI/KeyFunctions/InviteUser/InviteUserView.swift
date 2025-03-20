//
//  InviteUserView.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SwiftUI
import SendbirdChatSDK

/// A view that displays a InviteUser
public struct InviteUserView: View {
    // MARK: - Properties
    @Environment(\.dismiss)
    private var dismiss
    
    var configurations: [(SBUInviteUserViewController) -> Void] = []
    
    @ObservedObject private var provider: InviteUserViewProvider
    
    init(provider: InviteUserViewProvider) {
        self.provider = provider  // Default
    }
    
    public var body: some View {
        SBUViewControllerSet.InviteUserViewController
            .swiftUI {
                createViewController()
            }
            .injectData { viewController in
                if self.shouldUpdateData(viewController: viewController) {
                    // Inject data into view model and load
                    viewController.viewModel?.initializeAndLoad(
                        channelURL: self.provider.channelURL,
                        channelType: .group,
                        users: self.provider.customUsers,
                        inviteListType: .users
                    )
                }
            }
            .configure { viewController in
                viewController.dismissAction = {
                    dismiss()
                }
                
                // Used in SubViewBuilder
                configurations.forEach { config in
                    config(viewController)
                }
                
                // Apply viewUpdateHandlers recursively
                viewConverter.applyViewUpdates(to: viewController)
            }
            .switchUIKitNavigationBar()
            .onDisappear {
                if GlobalOptions.enableViewAdaptorAutoReset {
                    SBViewConverterSet.InviteUser = InviteUserViewConverter()
                }
            }
    }
    
    // MARK: - Methods
    private func createViewController() -> SBUInviteUserViewController {
        let viewController = SBUViewControllerSet.InviteUserViewController.init(
            channelURL: self.provider.channelURL,
            users: self.provider.customUsers
        )
        self.provider.bind(viewController: viewController)
        return viewController
    }
    
    private func shouldUpdateData(viewController: SBUInviteUserViewController) -> Bool {
        let shouldUpdateChannelURL = viewController.viewModel?.channelURL == "" && self.provider.channelURL != ""
        let shouldUpdateCustomUsers = viewController.viewModel?.customizedUsers == nil && self.provider.customUsers != nil
        return shouldUpdateChannelURL || shouldUpdateCustomUsers
    }
}

// MARK: - Initializers
/// InviteUserView initializers
public extension InviteUserView {
    // MARK: - typealias
    typealias ListContent = InviteUserViewConverter.List

    init(
        provider: InviteUserViewProvider,
        headerItem: (() -> InviteUserType.HeaderItem)? = nil,
        listItem: (() -> InviteUserType.ListItem)? = nil
    ) {
        self.provider = provider
        
        if let headerItem { _ = headerItem() }
        if let listItem { _ = listItem() }

        // Apply view converter in viewConverterSet.
        self.applyViewConverterSet()
    }

    // TODO: After entire content is implemented
    internal init<Content: View>(
        provider: InviteUserViewProvider,
        headerItem: (() -> InviteUserType.HeaderItem)? = nil,
        list: @escaping (ListContent.TableView.ViewConfig) -> Content
    ) {
        self.provider = provider
        
        typealias ViewConverterType = ViewConverter<ListContent.TableView.ViewConfig>
        let listViewConverter: ViewConverterType = ViewConverter { listConfig in
            UIHostingController(rootView: list(listConfig)).view
        }

        self.viewConverter.list.tableView.entireContent = listViewConverter
        self.viewConverter.list.tableView.viewUpdateHandlers[.entireContent] = { viewController in
            viewController.listComponent?.reloadTableView()
        }

        // Apply view converter in viewConverterSet.
        self.applyViewConverterSet()
    }
}

#Preview {
    NavigationView {
        InviteUserView(provider: .init(channelURL:""))
    }
}
