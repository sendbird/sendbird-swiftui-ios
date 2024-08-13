//
//  OpenParticipantListView.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SwiftUI
import SendbirdChatSDK

/// A view that displays a OpenParticipantList
public struct OpenParticipantListView: View {
    // MARK: - Properties
    @Environment(\.dismiss)
    private var dismiss
    
    var configurations: [(SBUUserListViewController) -> Void] = []
    
    private var channelURL: String
    private var users: [SBUUser]?
    
    // MARK: - Methods
    public var body: some View {
        SBUViewControllerSet.OpenUserListViewController
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
    
    private func createViewController() -> SBUUserListViewController {
        let viewController = SBUViewControllerSet.OpenUserListViewController.init(
            channelURL: self.channelURL,
            channelType: .open,
            users: self.users,
            userListType: .participants
        )
        return viewController
    }
}

// MARK: - Initializers
/// OpenParticipantListView initializers
public extension OpenParticipantListView {
    // MARK: - typealias
    typealias ListContent = OpenParticipantListViewConverter.List
    
    init(
        channelURL: String,
        users: [SBUUser]? = nil
    ) {
        self.channelURL = channelURL
        self.users = users
    }

    init(
        channelURL: String,
        users: [SBUUser]? = nil,
        headerItem: (() -> OpenMemberListType.HeaderItem)? = nil,
        listItem: (() -> OpenMemberListType.ListItem)? = nil
    ) {
        self.channelURL = channelURL
        self.users = users
        
        if let headerItem { _ = headerItem() }
        if let listItem { _ = listItem() }
        
        // Apply view converter in viewConverterSet.
        self.applyViewConverterSet()
    }

    init<Content: View>(
        channelURL: String,
        users: [SBUUser]? = nil,
        headerItem: (() -> OpenMemberListType.HeaderItem)? = nil,
        list: @escaping (ListContent.TableView.ViewConfig) -> Content
    ) {
        self.channelURL = channelURL
        self.users = users
        
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
        OpenParticipantListView(channelURL: "")
    }
}
