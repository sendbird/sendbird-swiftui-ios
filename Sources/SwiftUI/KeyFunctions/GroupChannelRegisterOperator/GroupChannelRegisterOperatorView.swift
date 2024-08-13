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
    
    private var channelURL: String
    private var users: [SBUUser]?
    
    // MARK: - Methods
    public var body: some View {
        SBUViewControllerSet.GroupChannelRegisterOperatorViewController
            .swiftUI {
                createViewController()
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
    }
    
    private func createViewController() -> SBURegisterOperatorViewController {
        let viewController = SBUViewControllerSet.GroupChannelRegisterOperatorViewController.init(
            channelURL: self.channelURL,
            users: self.users
        )
        return viewController
    }
}

// MARK: - Initializers
/// GroupChannelRegisterOperatorView initializers
public extension GroupChannelRegisterOperatorView {
    // MARK: - typealias
    // TODO: Initializer 에서 필요하면 구현
    // typealias ListContent = GroupChannelRegisterOperatorViewConverter.List
    
    init(
        channelURL: String,
        users: [SBUUser]? = nil
    ) {
        self.channelURL = channelURL
        self.users = users
    }
// (↓↓ example ↓↓)
    init(
        channelURL: String,
        users: [SBUUser]? = nil,
        headerItem: (() -> GroupChannelRegisterOperatorType.HeaderItem)? = nil
    ) {
        self.channelURL = channelURL
        self.users = users

        if let headerItem { _ = headerItem() }
//        if let listItem { _ = listItem() }

        // Apply view converter in viewConverterSet.
        self.applyViewConverterSet()
    }
//
//    init<Content: View>(
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
        GroupChannelRegisterOperatorView(channelURL: "")
    }
}