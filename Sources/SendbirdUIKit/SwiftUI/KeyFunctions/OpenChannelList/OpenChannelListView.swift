//
//  OpenChannelListView.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SwiftUI
import SendbirdChatSDK

/// A view that displays a OpenChannelList
public struct OpenChannelListView: View {
    // MARK: - Properties
    @Environment(\.dismiss)
    private var dismiss

    var configurations: [(SBUOpenChannelListViewController) -> Void] = []

    private var channelListQuery: OpenChannelListQuery?

    // MARK: - Methods
    public var body: some View {
        SBUViewControllerSet.OpenChannelListViewController
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
    
    private func createViewController() -> SBUOpenChannelListViewController {
        let viewController = SBUViewControllerSet.OpenChannelListViewController.init(
            channelListQuery: self.channelListQuery
        )
        return viewController
    }
}

// MARK: - Initializers
/// OpenChannelListView initializers
public extension OpenChannelListView {
    // MARK: - typealias
    typealias ListContent = OpenChannelListViewConverter.List
    
    init(channelListQuery: OpenChannelListQuery? = nil) {
        self.channelListQuery = channelListQuery
    }
    
    init(
        channelListQuery: OpenChannelListQuery? = nil,
        headerItem: (() -> OpenChannelListType.HeaderItem)? = nil,
        listItem: (() -> OpenChannelListType.ListItem)? = nil
    ) {
        self.channelListQuery = channelListQuery

        if let headerItem { _ = headerItem() }
        if let listItem { _ = listItem() }

        // Apply view converter in viewConverterSet.
        self.applyViewConverterSet()
    }

    init<Content: View>(
        channelListQuery: OpenChannelListQuery? = nil,
        headerItem: (() -> OpenChannelListType.HeaderItem)? = nil,
        @ViewBuilder list: @escaping (ListContent.TableView.ViewConfig) -> Content
    ) {
        self.init(channelListQuery: channelListQuery, headerItem: headerItem, listItem: nil)

        typealias ViewConverterType = ViewConverter<ListContent.TableView.ViewConfig>
        let listViewConverter: ViewConverterType = ViewConverter { listConfig in
            UIHostingController(rootView: list(listConfig)).view
        }
        
        viewConverter.list.viewUpdateHandlers[.entireContent] = { viewController in
            viewController.listComponent?.reloadTableView()
        }
        self.viewConverter.list.tableView.entireContent = listViewConverter
        
        // Apply view converter in viewConverterSet.
        self.applyViewConverterSet()
    }
}

#Preview {
    NavigationView {
        OpenChannelListView()
    }
}
