//
//  MessageSearchView.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SwiftUI
import SendbirdChatSDK

/// A view that displays a MessageSearch
public struct MessageSearchView: View {
    // MARK: - Properties
    @Environment(\.dismiss)
    private var dismiss
    
    var configurations: [(SBUMessageSearchViewController) -> Void] = []
    
    var provider: MessageSearchViewProvider
    
    public init(provider: MessageSearchViewProvider) {
        self.provider = provider  // Default provider
    }
    
    public var body: some View {
        SBUViewControllerSet.MessageSearchViewController
            .swiftUI {
                createViewController()
            }
            .injectData { viewController in
                if self.shouldUpdateData(viewController: viewController) {
                    // Inject data into view model and load
                    viewController.viewModel?.initializeAndLoad(
                        channelURL: self.provider.channelURL,
                        params: self.provider.messageSearchQueryParams
                    )
                }
            }
            .configure { viewController in
//                viewController.dismissAction = {
//                    dismiss()
//                }
                
                // Used in SubViewBuilder
                configurations.forEach { config in
                    config(viewController)
                }
                
                // Apply viewUpdateHandlers recursively
                viewConverter.applyViewUpdates(to: viewController)
            }
            .switchUIKitNavigationBar()
            .onDisappear {
                SBViewConverterSet.MessageSearch = MessageSearchViewConverter()
            }
    }
    
    // MARK: - Methods
    private func createViewController() -> SBUMessageSearchViewController {
        let viewController = SBUViewControllerSet.MessageSearchViewController.init(
            channelURL: self.provider.channelURL
        )
        self.provider.bind(viewController: viewController)
        return viewController
    }
    
    private func shouldUpdateData(viewController: SBUMessageSearchViewController) -> Bool {
        let shouldUpdateChannelURL = viewController.viewModel?.channelURL == "" && self.provider.channelURL != ""
        let shouldUpdateMessageSearchQueryParams = viewController.viewModel?.messageSearchQuery == nil && self.provider.messageSearchQueryParams != nil
        return shouldUpdateChannelURL || shouldUpdateMessageSearchQueryParams
    }
}

// MARK: - Initializers
/// MessageSearchView initializers
public extension MessageSearchView {
    // MARK: - typealias
    // typealias ListContent = MessageSearchViewConverter.List

    // TODO: public after beta
    private init(
        provider: MessageSearchViewProvider,
        headerItem: (() -> MessageSearchType.HeaderItem)? = nil,
        listItem: (() -> MessageSearchType.ListItem)? = nil
    ) {
        self.provider = provider

        if let headerItem { _ = headerItem() }
        if let listItem { _ = listItem() }

        // Apply view converter in viewConverterSet.
        self.applyViewConverterSet()
    }
}

#Preview {
    NavigationView {
        MessageSearchView(provider: MessageSearchViewProvider(channelURL: ""))
    }
}
