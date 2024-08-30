//
//  GroupChannelListView.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SwiftUI
import SendbirdChatSDK

/// A view that displays a GroupChannelList
public struct GroupChannelListView: View {
    // MARK: - Properties
    @Environment(\.dismiss)
    private var dismiss
    
    @ObservedObject var payloadManager = SendbirdUI.PushPayloadManager.shared
    
    var configurations: [(SBUGroupChannelListViewController) -> Void] = []
    private var channelListQuery: GroupChannelListQuery?
    
    // MARK: - Methods
    public var body: some View {
        SBUViewControllerSet.GroupChannelListViewController
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
                
                moveToChannelIfNeeded(payloadManager.channelURL)
            }
            .switchUIKitNavigationBar()
    }
    
    private func createViewController() -> SBUGroupChannelListViewController {
        let viewController = SBUViewControllerSet.GroupChannelListViewController.init(
            channelListQuery: self.channelListQuery
        )
        return viewController
    }
    
    private func moveToChannelIfNeeded(_ channelURL: String?) {
        DispatchQueue.main.async {
            if let channelURL = payloadManager.channelURL {
                payloadManager.clear()
                SendbirdUI.moveToChannel(channelURL: channelURL, channelType: .group)
            }
        }
    }
}

// MARK: - Initializers
/// GroupChannelListView initializers
public extension GroupChannelListView {
    // MARK: - typealias
    typealias ListContent = GroupChannelListViewConverter.List
    
    init(
        channelListQuery: GroupChannelListQuery? = nil,
        headerItem: (() -> GroupChannelListType.HeaderItem)? = nil,
        listItem: (() -> GroupChannelListType.ListItem)? = nil
    ) {
        self.channelListQuery = channelListQuery
        
        if let headerItem { _ = headerItem() }
        if let listItem { _ = listItem() }
        
        // Apply view converter in viewConverterSet.
        self.applyViewConverterSet()
    }
    
    init<Content: View>(
        channelListQuery: GroupChannelListQuery? = nil,
        headerItem: (() -> GroupChannelListType.HeaderItem)? = nil,
        list: @escaping (ListContent.TableView.ViewConfig) -> Content
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
        GroupChannelListView()
            .groupChannelView { channelURL, _, _ in
                GroupChannelView(channelURL: channelURL)
            }
    }
}
