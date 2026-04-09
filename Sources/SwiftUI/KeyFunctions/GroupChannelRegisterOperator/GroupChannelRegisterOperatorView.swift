//
//  GroupChannelRegisterOperatorView.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SwiftUI
import SendbirdChatSDK

/// A view that displays a GroupChannelRegisterOperator
public struct GroupChannelRegisterOperatorView: View {
    // MARK: - Properties
    @Environment(\.dismiss)
    private var dismiss
    
    var configurations: [(SBURegisterOperatorViewController) -> Void] = []
    
    // Non-optional since `channelURL` is required.
    @ObservedObject private var provider: GroupChannelRegisterOperatorViewProvider
    
    init(provider: GroupChannelRegisterOperatorViewProvider) {
        self.provider = provider
    }
    
    public var body: some View {
        SBUViewControllerSet.GroupChannelRegisterOperatorViewController
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
                        inviteListType: .operators
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
                    SBViewConverterSet.GroupChannelRegisterOperator = GroupChannelRegisterOperatorViewConverter()
                }
            }
    }

    // MARK: - Methods
    private func createViewController() -> SBURegisterOperatorViewController {
        let viewController = SBUViewControllerSet.GroupChannelRegisterOperatorViewController.init(
            channelURL: self.provider.channelURL,
            users: self.provider.customUsers
        )
        
        // hook up VC, VM into provider
        self.provider.bind(viewController: viewController)
        
        return viewController
    }
    
    private func shouldUpdateData(viewController: SBURegisterOperatorViewController) -> Bool {
        let shouldUpdateChannelURL = viewController.viewModel?.channelURL == "" && self.provider.channelURL != ""
        let shouldUpdateCustomUsers = viewController.viewModel?.customizedUsers == nil && self.provider.customUsers != nil
        return shouldUpdateChannelURL || shouldUpdateCustomUsers
    }
}

// MARK: - Initializers
/// GroupChannelRegisterOperatorView initializers
public extension GroupChannelRegisterOperatorView {
    // MARK: - typealias
    // typealias ListContent = GroupChannelRegisterOperatorViewConverter.List
    
    /// Initializes a new `GroupChannelRegisterOperatorView` with the given provider and optional header item.
    init(
        provider: GroupChannelRegisterOperatorViewProvider,
        headerItem: (() -> GroupChannelRegisterOperatorType.HeaderItem)? = nil
    ) {
        self.provider = provider

        if let headerItem { _ = headerItem() }
//        if let listItem { _ = listItem() }

        // Apply view converter in viewConverterSet.
        self.applyViewConverterSet()
    }

    // TODO: After entire content is implemented
//    internal init<Content: View>(
//        channelListQuery: GroupChannelListQuery? = nil,
//        headerItem: (() -> Sendbird.View.GroupChannel.ChannelList.HeaderItem)? = nil,
//        list: @escaping (ListContent.ViewConfig) -> Content
//    ) {
//        self.init(channelListQuery: channelListQuery, headerItem: headerItem, listItem: nil)
//
//        typealias ViewConverterType = ViewConverter<ListContent.ViewConfig>
//        let listViewConverter: ViewConverterType = ViewConverter { listConfig in
//            UIHostingController(rootView: list(listConfig)).view
//        }
//
//        self.viewConverter.list.entireContent = listViewConverter
//        self.viewConverter.list.viewUpdateHandlers[.entireContent] = { vc in
//            vc.listComponent?.reloadTableView()
//        }
//
//        // Apply view converter in viewConverterSet.
//        self.applyViewConverterSet()
//    }
}

#Preview {
    NavigationView {
        GroupChannelRegisterOperatorView(provider: .init(channelURL: ""))
    }
}
