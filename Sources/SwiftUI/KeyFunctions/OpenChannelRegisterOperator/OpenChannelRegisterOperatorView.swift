//
//  OpenChannelRegisterOperatorView.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SwiftUI
import SendbirdChatSDK

/// A view that displays a OpenChannelRegisterOperator
public struct OpenChannelRegisterOperatorView: View {
    // MARK: - Properties
    @Environment(\.dismiss)
    private var dismiss
    
    var configurations: [(SBURegisterOperatorViewController) -> Void] = []
    
    // Non-optional since `channelURL` is required.
    @ObservedObject private var provider: OpenChannelRegisterOperatorViewProvider
    
    init(provider: OpenChannelRegisterOperatorViewProvider) {
        self.provider = provider
    }
    
    /// The content and behavior of the view.
    public var body: some View {
        SBUViewControllerSet.OpenChannelRegisterOperatorViewController
            .swiftUI {
                createViewController()
            }
            .injectData { viewController in
                if self.shouldUpdateData(viewController: viewController) {
                    // Inject data into view model and load
                    viewController.viewModel?.initializeAndLoad(
                        channelURL: self.provider.channelURL,
                        channelType: .open,
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
                    SBViewConverterSet.OpenChannelRegisterOperator = OpenChannelRegisterOperatorViewConverter()
                }
            }
    }
    
    // MARK: - Methods
    private func createViewController() -> SBURegisterOperatorViewController {
        let viewController = SBUViewControllerSet.OpenChannelRegisterOperatorViewController.init(
            channelURL: self.provider.channelURL,
            channelType: .open,
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
/// OpenChannelRegisterOperatorView initializers
public extension OpenChannelRegisterOperatorView {
    // MARK: - typealias
    // typealias ListContent = OpenChannelRegisterOperatorViewConverter.List

    /// Initializes a new view with the given parameters.
    init(
        provider: OpenChannelRegisterOperatorViewProvider,
        headerItem: (() -> OpenChannelRegisterOperatorType.HeaderItem)? = nil
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
        OpenChannelRegisterOperatorView(provider: .init(channelURL: ""))
    }
}
