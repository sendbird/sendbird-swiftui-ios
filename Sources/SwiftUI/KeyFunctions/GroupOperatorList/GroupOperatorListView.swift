//
//  GroupOperatorListView.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SwiftUI
import SendbirdChatSDK

/// A view that displays a GroupOperatorList
public struct GroupOperatorListView: View {
    // MARK: - Properties
    @Environment(\.dismiss)
    private var dismiss
    
    var configurations: [(SBUUserListViewController) -> Void] = []
     
    // Non-optional since `channelURL` is required.
    @ObservedObject private var provider: GroupOperatorListViewProvider
    
    init(provider: GroupOperatorListViewProvider) {
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
                        userListType: .operators
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
                SBViewConverterSet.GroupOperatorList = GroupOperatorListViewConverter()
            }
    }
    
    // MARK: - Methods
    private func createViewController() -> SBUUserListViewController {
        let viewController = SBUViewControllerSet.GroupUserListViewController.init(
            channelURL: self.provider.channelURL,
            channelType: .group,
            users: self.provider.customUsers,
            userListType: .operators
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
/// GroupOperatorListView initializers
public extension GroupOperatorListView {
    // MARK: - typealias
    typealias ListContent = GroupOperatorListViewConverter.List
    
    init(
        provider: GroupOperatorListViewProvider,
        headerItem: (() -> GroupOperatorListType.HeaderItem)? = nil,
        listItem: (() -> GroupOperatorListType.ListItem)? = nil
    ) {
        self.provider = provider

        if let headerItem { _ = headerItem() }
        if let listItem { _ = listItem() }

        // Apply view converter in viewConverterSet.
        self.applyViewConverterSet()
    }
    
    // TODO: After entire content is implemented
    internal init<Content: View>(
        provider: GroupOperatorListViewProvider,
        headerItem: (() -> GroupOperatorListType.HeaderItem)? = nil,
        list: @escaping (ListContent.TableView.ViewConfig) -> Content
    ) {
        self.provider = provider
        
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

// MARK: Event handler interfaces
public extension GroupOperatorListView {
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
        GroupOperatorListView(provider: .init(channelURL: ""))
    }
}
