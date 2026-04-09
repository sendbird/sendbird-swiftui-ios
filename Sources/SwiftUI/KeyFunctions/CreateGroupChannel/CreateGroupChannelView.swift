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
    
    @ObservedObject private var provider: CreateGroupChannelViewProvider
    
    /// Initializes a new view with default settings.
    public init() {
        self.provider = CreateGroupChannelViewProvider()
    }

    /// The content and behavior of the view.
    public var body: some View {
        SBUViewControllerSet.CreateChannelViewController
            .swiftUI {
                createViewController()
            }
            .injectData { viewController in
                if self.shouldUpdateData(viewController: viewController) {
                    // Inject data into view model and load
                    viewController.viewModel?.initializeAndLoad(
                        users: self.provider.customUsers
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
                    SBViewConverterSet.CreateGroupChannel = CreateGroupChannelViewConverter()
                }
            }
    }

    // MARK: - Methods
    private func createViewController() -> SBUCreateChannelViewController {
        let viewController = SBUViewControllerSet.CreateChannelViewController.init(
            users: self.provider.customUsers,
            type: self.provider.type
        )
        self.provider.bind(viewController: viewController)
        return viewController
    }
    
    private func shouldUpdateData(viewController: SBUCreateChannelViewController) -> Bool {
        let shouldUpdateCustomUsers = viewController.viewModel?.customizedUsers == nil && self.provider.customUsers != nil
        return shouldUpdateCustomUsers
    }
}

// MARK: - Initializers
/// CreateGroupChannelView initializers
public extension CreateGroupChannelView {
    // MARK: - typealias
    /// The list content type alias for CreateGroupChannelView.
    typealias ListContent = CreateGroupChannelViewConverter.List

    /// Initializes a new view with the given parameters.
    init(
        provider: CreateGroupChannelViewProvider? = nil,
        headerItem: (() -> CreateGroupChannelType.HeaderItem)? = nil,
        listItem: (() -> CreateGroupChannelType.ListItem)? = nil
    ) {
        self.provider = provider ?? CreateGroupChannelViewProvider()

        if let headerItem { _ = headerItem() }
        if let listItem { _ = listItem() }

        // Apply view converter in viewConverterSet.
        self.applyViewConverterSet()
    }

    // TODO: After entire content is implemented
    internal init<Content: View>(
        provider: CreateGroupChannelViewProvider? = nil,
        headerItem: (() -> CreateGroupChannelType.HeaderItem)? = nil,
        list: @escaping (ListContent.TableView.ViewConfig) -> Content
    ) { 
        self.provider = provider ?? CreateGroupChannelViewProvider()
        
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
public extension CreateGroupChannelView {
    /// Called when a row is selected in the create group channel view.
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
        CreateGroupChannelView()
    }
}
