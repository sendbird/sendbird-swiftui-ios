//
//  CreateGroupChannelView.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SwiftUI
import SendbirdChatSDK

/// A view that displays a CreateGroupChannel
public struct CreateGroupChannelView: View {
    // MARK: - Properties
    @Environment(\.dismiss)
    private var dismiss
    
    var configurations: [(SBUCreateChannelViewController) -> Void] = []
    
    private var users: [SBUUser]?
    private var type: ChannelCreationType = .group
    
    // MARK: - Methods
    public init() {}
    
    public var body: some View {
        SBUViewControllerSet.CreateChannelViewController
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
    
    private func createViewController() -> SBUCreateChannelViewController {
        let viewController = SBUViewControllerSet.CreateChannelViewController.init(
            users: self.users,
            type: self.type
        )
        return viewController
    }
}

// MARK: - Initializers
/// CreateGroupChannelView initializers
public extension CreateGroupChannelView {
    // MARK: - typealias
    typealias ListContent = CreateGroupChannelViewConverter.List
    
    init(
        users: [SBUUser]? = nil,
        type: ChannelCreationType = .group,
        headerItem: (() -> CreateGroupChannelType.HeaderItem)? = nil,
        listItem: (() -> CreateGroupChannelType.ListItem)? = nil
    ) {
        self.users = users
        self.type = type

        if let headerItem { _ = headerItem() }
        if let listItem { _ = listItem() }

        // Apply view converter in viewConverterSet.
        self.applyViewConverterSet()
    }

    init<Content: View>(
        users: [SBUUser]? = nil,
        type: ChannelCreationType = .group,
        headerItem: (() -> CreateGroupChannelType.HeaderItem)? = nil,
        list: @escaping (ListContent.TableView.ViewConfig) -> Content
    ) {
        self.users = users
        self.type = type
        
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
        CreateGroupChannelView()
    }
}
