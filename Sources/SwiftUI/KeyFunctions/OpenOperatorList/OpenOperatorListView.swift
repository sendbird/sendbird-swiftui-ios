//
//  OpenOperatorListView.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SwiftUI
import SendbirdChatSDK

/// A view that displays a OpenOperatorList
public struct OpenOperatorListView: View {
    // MARK: - Properties
    @Environment(\.dismiss)
    private var dismiss
    
    var configurations: [(SBUUserListViewController) -> Void] = []
     
    // Non-optional since `channelURL` is required.
    @ObservedObject private var provider: OpenOperatorListViewProvider
    
    init(provider: OpenOperatorListViewProvider) {
        self.provider = provider
    }
    
    /// The content and behavior of the view.
    public var body: some View {
        SBUViewControllerSet.OpenUserListViewController
            .swiftUI {
                createViewController()
            }
            .injectData { viewController in
                if self.shouldUpdateData(viewController: viewController) {
                    // Inject data into view model and load
                    viewController.viewModel?.initializeAndLoad(
                        channelURL: self.provider.channelURL,
                        channelType: .open,
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
                if GlobalOptions.enableViewAdaptorAutoReset {
                    SBViewConverterSet.OpenOperatorList = OpenOperatorListViewConverter()
                }
            }
    }
    
    // MARK: - Methods
    private func createViewController() -> SBUUserListViewController {
        let viewController = SBUViewControllerSet.OpenUserListViewController.init(
            channelURL: self.provider.channelURL,
            channelType: .open,
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
/// OpenOperatorListView initializers
public extension OpenOperatorListView {
    // MARK: - typealias
    /// The list content type alias for OpenOperatorListView.
    typealias ListContent = OpenOperatorListViewConverter.List

    /// Initializes a new view with the given parameters.
    init(
        provider: OpenOperatorListViewProvider,
        headerItem: (() -> OpenOperatorListType.HeaderItem)? = nil,
        listItem: (() -> OpenOperatorListType.ListItem)? = nil
    ) {
        self.provider = provider

        if let headerItem { _ = headerItem() }
        if let listItem { _ = listItem() }

        // Apply view converter in viewConverterSet.
        self.applyViewConverterSet()
    }
    
    // TODO: After entire content is implemented
    internal init<Content: View>(
        provider: OpenOperatorListViewProvider,
        headerItem: (() -> OpenOperatorListType.HeaderItem)? = nil,
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
public extension OpenOperatorListView {
    /// Called when a row is selected in the open operator list.
    func onSendbirdSelectRow(_ selectRowHandler: @escaping ((_ indexPath: IndexPath) -> Void)) -> Self {
        let copy = self
        copy.provider.eventHandlers.selectRowHandler = selectRowHandler
        return copy
    }

    /// Called when an error occurs.
    func onSendbirdError(_ errorHandler: @escaping ((_ error: SBError?) -> Void)) -> Self {
        let copy = self
        copy.provider.eventHandlers.errorHandler = errorHandler
        return copy
    }
}

#Preview {
    NavigationView {
        OpenOperatorListView(provider: .init(channelURL: ""))
    }
}
