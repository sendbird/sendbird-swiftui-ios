//
//  GroupMemberListView.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SwiftUI
import SendbirdChatSDK

/// A view that displays a GroupMemberList
public struct GroupMemberListView: View {
    // MARK: - Properties
    @Environment(\.dismiss)
    private var dismiss
    
    var configurations: [(SBUUserListViewController) -> Void] = []
     
    // Non-optional since `channelURL` is required.
    @ObservedObject private var provider: GroupMemberListViewProvider
    
    init(provider: GroupMemberListViewProvider) {
        self.provider = provider
    }
    
    public var body: some View {
        SBUViewControllerSet.GroupUserListViewController
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
                        userListType: .members
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
                    SBViewConverterSet.GroupMemberList = GroupMemberListViewConverter()
                }
            }
    }
    
    // MARK: - Methods
    private func createViewController() -> SBUUserListViewController {
        let viewController = SBUViewControllerSet.GroupUserListViewController.init(
            channelURL: self.provider.channelURL,
            channelType: .group,
            users: self.provider.customUsers,
            userListType: .members
        )
        
        // hook up VC, VM into provider
        self.provider.bind(viewController: viewController)
        
        return viewController
    }
        
    private func shouldUpdateData(viewController: SBUUserListViewController) -> Bool {
        let shouldUpdateChannelURL = viewController.viewModel?.channelURL == "" && self.provider.channelURL != ""
        let shouldUpdateCustomUsers = viewController.viewModel?.customizedUsers == nil && self.provider.customUsers != nil
        return shouldUpdateChannelURL || shouldUpdateCustomUsers
    }
}

// MARK: - Initializers
/// GroupMemberListView initializers
public extension GroupMemberListView {
    // MARK: - typealias
    typealias ListContent = GroupMemberListViewConverter.List
    
    init(
        provider: GroupMemberListViewProvider,
        userListType: ChannelUserListType = .members,
        headerItem: (() -> GroupMemberListType.HeaderItem)? = nil,
        listItem: (() -> GroupMemberListType.ListItem)? = nil
    ) {
        self.provider = provider

        if let headerItem { _ = headerItem() }
        if let listItem { _ = listItem() }

        // Apply view converter in viewConverterSet.
        self.applyViewConverterSet()
    }
    
    // TODO: After entire content is implemented
    internal init<Content: View>(
        provider: GroupMemberListViewProvider,
        headerItem: (() -> GroupMemberListType.HeaderItem)? = nil,
        list: @escaping (ListContent.TableView.ViewConfig) -> Content
    ) {
        self.init(provider: provider, headerItem: headerItem, listItem: nil)
        
        typealias ViewConverterType = ViewConverter<ListContent.TableView.ViewConfig>
        let listViewConverter: ViewConverterType = ViewConverter { listConfig in
            ProviderAndConfigWrappedHostingView(
                provider: provider,
                config: listConfig,
                content: list
            ).createHostingView()
        }
        
        self.viewConverter.list.tableView.entireContent = listViewConverter
        self.viewConverter.list.tableView.viewUpdateHandlers[.entireContent] = { viewController in
            viewController.listComponent?.reloadTableView()
        }
        
        // Apply view converter in viewConverterSet.
        self.applyViewConverterSet()
    }
}

// MARK: Event handler interfaces
public extension GroupMemberListView {
    func onSendbirdSelectRow(_ selectRowHandler: @escaping ((_ indexPath: IndexPath) -> Void)) -> Self {
        let copy = self
        copy.provider.eventHandlers.selectRowHandler = selectRowHandler
        return copy
    }
    
    func onSendbirdError(_ errorHandler: @escaping ((_ error: SBError?) -> Void)) -> Self {
        let copy = self
        copy.provider.eventHandlers.errorHandler = errorHandler
        return copy
    }
}

#Preview {
    NavigationView {
        GroupMemberListView(provider: .init(channelURL: ""))
    }
}
