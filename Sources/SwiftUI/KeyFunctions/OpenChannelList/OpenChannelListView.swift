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

    @ObservedObject var provider: OpenChannelListViewProvider
    
    public init() {
        self.provider = OpenChannelListViewProvider()  // Default provider
    }

    public var body: some View {
        SBUViewControllerSet.OpenChannelListViewController
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
            }
            .switchUIKitNavigationBar()
            .onDisappear {
                SBViewConverterSet.OpenChannelList = OpenChannelListViewConverter()
            }
    }
    
    // MARK: - Methods
    private func createViewController() -> SBUOpenChannelListViewController {
        let viewController = SBUViewControllerSet.OpenChannelListViewController.init(
            channelListQuery: self.provider.channelListQuery
        )
        
        // connect VC, VM <-> provider
        self.provider.bind(viewController: viewController)
        
        return viewController
    }

    private func shouldUpdateData(viewController: SBUOpenChannelListViewController) -> Bool {
        let shouldUpdateChannelListQuery = viewController.viewModel?.channelListQuery == nil && self.provider.channelListQuery != nil
        return shouldUpdateChannelListQuery
    }
}

// MARK: - Initializers
/// OpenChannelListView initializers
public extension OpenChannelListView {
    // MARK: - typealias
    typealias ListContent = OpenChannelListViewConverter.List
    
    init(
        provider: OpenChannelListViewProvider? = nil,
        headerItem: (() -> OpenChannelListType.HeaderItem)? = nil,
        listItem: (() -> OpenChannelListType.ListItem)? = nil
    ) {
        self.provider = provider ?? OpenChannelListViewProvider()  // Default provider

        if let headerItem { _ = headerItem() }
        if let listItem { _ = listItem() }

        // Apply view converter in viewConverterSet.
        self.applyViewConverterSet()
    }

    // TODO: After entire content is implemented
    internal init<Content: View>(
        provider: OpenChannelListViewProvider? = nil,
        headerItem: (() -> OpenChannelListType.HeaderItem)? = nil,
        @ViewBuilder list: @escaping (ListContent.TableView.ViewConfig) -> Content
    ) {
        self.init(provider: provider, headerItem: headerItem, listItem: nil)

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
public extension OpenChannelListView {
    func onSendbirdSelectRow(
        _ selectRowHandler: @escaping (_ indexPath: IndexPath) -> Void
    ) -> Self {
        let copy = self
        copy.provider.eventHandlers.selectRowHandler = selectRowHandler
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
}

#Preview {
    NavigationView {
        OpenChannelListView()
    }
}
