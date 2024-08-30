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
    
    private var channelURL: String
    
    // MARK: - Methods
    public var body: some View {
        SBUViewControllerSet.MessageSearchViewController
            .swiftUI {
                createViewController()
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
    }
    
    private func createViewController() -> SBUMessageSearchViewController {
        let viewController = SBUViewControllerSet.MessageSearchViewController.init(
            channelURL: self.channelURL
        )
        return viewController
    }
}

// MARK: - Initializers
/// MessageSearchView initializers
public extension MessageSearchView {
    // MARK: - typealias
    // typealias ListContent = MessageSearchViewConverter.List
    
    init(channelURL: String) {
        self.channelURL = channelURL
    }
    
    // TODO: public after beta
    private init(
        channelURL: String,
        headerItem: (() -> MessageSearchType.HeaderItem)? = nil,
        listItem: (() -> MessageSearchType.ListItem)? = nil
    ) {
        self.channelURL = channelURL

        if let headerItem { _ = headerItem() }
        if let listItem { _ = listItem() }

        // Apply view converter in viewConverterSet.
        self.applyViewConverterSet()
    }
}

#Preview {
    NavigationView {
        MessageSearchView(channelURL: "")
    }
}
