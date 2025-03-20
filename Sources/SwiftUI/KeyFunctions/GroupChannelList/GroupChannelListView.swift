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
    
    @ObservedObject private var provider: GroupChannelListViewProvider
    
    public init() {
        self.provider = GroupChannelListViewProvider() // Default
    }
    
    public var body: some View {
        SBUViewControllerSet.GroupChannelListViewController
            .swiftUI {
                createViewController()
            }
            .injectData { viewController in
                if self.shouldUpdateData(viewController: viewController) {
                    // Inject data into view model and load
                    viewController.viewModel?.initializeAndLoad(
                        channelListQuery: self.provider.channelListQuery
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
                
                moveToChannelIfNeeded(payloadManager.channelURL)
            }
            .switchUIKitNavigationBar()
            .onDisappear {
                if GlobalOptions.enableViewAdaptorAutoReset {
                    SBViewConverterSet.GroupChannelList = GroupChannelListViewConverter()
                }
            }
    }
    
    // MARK: - Methods
    private func createViewController() -> SBUGroupChannelListViewController {
        let viewController = SBUViewControllerSet.GroupChannelListViewController.init(
            channelListQuery: self.channelListQuery
        )

        // connect VC, VM <-> provider
        self.provider.bind(viewController: viewController)
        
        return viewController
    }
    
    private func shouldUpdateData(viewController: SBUGroupChannelListViewController) -> Bool {
        let shouldUpdateChannelListQuery = viewController.viewModel?.channelListQuery == nil && self.provider.channelListQuery != nil
        return shouldUpdateChannelListQuery
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
        provider: GroupChannelListViewProvider? = nil,
        headerItem: (() -> GroupChannelListType.HeaderItem)? = nil,
        listItem: (() -> GroupChannelListType.ListItem)? = nil
    ) {
        self.provider = provider ?? GroupChannelListViewProvider()
        self.channelListQuery = self.provider.channelListQuery
        
        if let headerItem { _ = headerItem() }
        if let listItem { _ = listItem() }
        
        // Apply view converter in viewConverterSet.
        self.applyViewConverterSet()
    }
    
    // TODO: After entire content is implemented
    internal init<Content: View>(
        provider: GroupChannelListViewProvider? = nil,
        headerItem: (() -> GroupChannelListType.HeaderItem)? = nil,
        list: @escaping (ListContent.TableView.ViewConfig) -> Content
    ) {
        self.init(
            provider: provider,
            headerItem: headerItem,
            listItem: nil
        )
        
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

// MARK: Event handler interfaces
public extension GroupChannelListView {
    func onSendbirdSelectRow(_ selectRowHandler: @escaping (_ indexPath: IndexPath) -> Void) -> Self {
        let copy = self
        copy.provider.eventHandlers.selectRowHandler = selectRowHandler
        return copy
    }
    
    func onSendbirdSelectLeaveChannel(_ selectLeaveChannelHandler: @escaping (_ channel: GroupChannel) -> Void) -> Self {
        let copy = self
        copy.provider.eventHandlers.selectLeaveChannelHandler = selectLeaveChannelHandler
        return copy
    }
    
    func onSendbirdChangePushTriggerOption(_ changePushTriggerOptionHandler: @escaping (_ channel: GroupChannel) -> Void) -> Self {
        let copy = self
        copy.provider.eventHandlers.changePushTriggerOptionHandler = changePushTriggerOptionHandler
        return copy
    }
    
    func onSendbirdConnectionStateChange(_ connectionStateChangeHandler: @escaping SendbirdConnectionStateChangeHandler) -> Self {
        let copy = self
        copy.provider.eventHandlers.connectionStateChangeHandler = connectionStateChangeHandler
        return copy
    }
    
    func onSendbirdError(_ errorHandler: @escaping SendbirdErrorHandler) -> Self {
        let copy = self
        copy.provider.eventHandlers.errorHandler = errorHandler
        return copy
    }
    
    // Note: Events from Chat SDK are not be available in SendbirdSwiftUI.
//    func onUpdatedChannels(_ handler: @escaping GroupChannelListUpdatedChannelsHandler) -> Self {
//        let copy = self
//        copy.manager?.eventHandlers.updatedChannelsHandler = handler
//        return copy
//    }
}

#Preview {
    NavigationView {
        GroupChannelListView()
            .groupChannelView { channelURL, _, _ in
                GroupChannelView(provider: .init(channelURL: channelURL))
            }
    }
}
