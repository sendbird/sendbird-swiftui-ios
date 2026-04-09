//
//  GroupChannelView.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SwiftUI
import SendbirdChatSDK

/// A view that displays a GroupChannel
public struct GroupChannelView: View {
    // MARK: - Properties
    @Environment(\.dismiss)
    private var dismiss
    
    var configurations: [(SBUGroupChannelViewController) -> Void] = []

    // for message search
    var highlightInfo: SBUHighlightMessageInfo?
    var useRightBarButtonItem: Bool = true
    
    // Non-optional since `channelURL` is required.
    @ObservedObject private var provider: GroupChannelViewProvider
    
    init(provider: GroupChannelViewProvider) {
        self.provider = provider  // Default
    }
    
    /// The content and behavior of the view.
    public var body: some View {
        SBUViewControllerSet.GroupChannelViewController
            .swiftUI {
                createViewController()
            }
            .injectData { viewController in
                if self.shouldUpdateData(viewController: viewController) {
                    // Inject data into view model and load
                    viewController.viewModel?.initializeAndLoad(
                        channelURL: self.provider.channelURL,
                        messageListParams: self.provider.messageListParams,
                        startingPoint: self.provider.startingPoint,
                        displaysLocalCachedListFirst: true
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
                    SBViewConverterSet.GroupChannel = GroupChannelViewConverter()
                }
            }
    }
    
    private func createViewController() -> SBUGroupChannelViewController {
        SBULog.info(
            """
            [\(Self.self).\(#function)] provider
            channelURL = \(provider.channelURL)
            startingPoint = \(String(describing: provider.startingPoint))
            messageListParams = \(String(describing: provider.messageListParams))
            """
        )
        
        let viewController = SBUViewControllerSet.GroupChannelViewController.init(
            channelURL: self.provider.channelURL,
            startingPoint: self.provider.startingPoint,
            messageListParams: self.provider.messageListParams
        )
        viewController.highlightInfo = self.highlightInfo
        viewController.useRightBarButtonItem = self.useRightBarButtonItem
        
        // connect VC, VM <-> provider
        self.provider.bind(viewController: viewController)
        
        return viewController
    }
    
    // MARK: - Methods
    // TODO: 이후에 필요하다면, 값 변화에 대해서 새로 그릴 수 있도록 처리
    private func shouldUpdateData(viewController: SBUGroupChannelViewController) -> Bool {
        let shouldUpdateChannelURL = viewController.viewModel?.channelURL == "" && self.provider.channelURL != ""
        let shouldUpdateMessageListParams = viewController.viewModel?.customizedMessageListParams == nil && self.provider.messageListParams != nil
        let shouldUpdateStartingPoint = viewController.viewModel?.startingPoint == nil && self.provider.startingPoint != nil
        return shouldUpdateChannelURL || shouldUpdateMessageListParams || shouldUpdateStartingPoint
    }
}

// MARK: - Initializers
/// GroupChannelView initializers
public extension GroupChannelView {
    // MARK: - typealias
    /// The list content type alias for GroupChannelView.
    typealias ListContent = GroupChannelViewConverter.List
    /// The input content type alias for GroupChannelView.
    typealias InputContent = GroupChannelViewConverter.Input

    /// Initializes a new view with the given parameters.
    init(
        provider: GroupChannelViewProvider,
        headerItem: (() -> GroupChannelType.HeaderItem)? = nil,
        listItem: (() -> GroupChannelType.ListItem)? = nil,
        inputItem: (() -> GroupChannelType.InputItem)? = nil
    ) {
        self.provider = provider
        
        if let headerItem { _ = headerItem() }
        if let listItem { _ = listItem() }
        if let inputItem { _ = inputItem() }
        
        self.applyViewConverterSet()
    }
    
    // TODO: After entire content is implemented
    internal init<Content: View>(
        provider: GroupChannelViewProvider,
        headerItem: (() -> GroupChannelType.HeaderItem)? = nil,
        list: @escaping (ListContent.TableView.ViewConfig) -> Content,
        inputItem: (() -> GroupChannelType.InputItem)? = nil
    ) {
        self.init(
            provider: provider,
            headerItem: headerItem,
            inputItem: inputItem
        )
        
        // list
        self.viewConverter.list.tableView.entireContent = ViewConverter { tableViewConfig in
            UIHostingController(rootView: list(tableViewConfig)).view
        }
        self.viewConverter.list.tableView.viewUpdateHandlers[.entireContent] = { viewController in
            viewController.listComponent?.applyViewConverter(.entireContent)
        }
        
        self.applyViewConverterSet()
    }
    
    // NOTE: This interface has been temporarily closed.
    private init<Content: View>(
        provider: GroupChannelViewProvider,
        headerItem: (() -> GroupChannelType.HeaderItem)? = nil,
        listItem: (() -> GroupChannelType.ListItem)? = nil,
        input: @escaping (InputContent.ViewConfig) -> Content
    ) {
        self.init(
            provider: provider,
            headerItem: headerItem,
            listItem: listItem
        )
        
        // SwiftUI TODO:  suggentedMentionList 할때 여기 .input 대신 .input.messageInputView. 로 해야하는거 아닌지 체크
        // input
        self.viewConverter.input.entireContent = ViewConverter { inputViewConfig in
            UIHostingController(rootView: input(inputViewConfig)).view
        }
        
        self.viewConverter.input.viewUpdateHandlers[.entireContent] = { viewController in
            viewController.inputComponent?.applyViewConverter(.entireContent)
        }
        
        self.applyViewConverterSet()
    }
    
    // NOTE: This interface has been temporarily closed.
    internal init<Content: View>(
        provider: GroupChannelViewProvider,
        headerItem: (() -> GroupChannelType.HeaderItem)? = nil,
        list: @escaping (ListContent.TableView.ViewConfig) -> Content,
        input: @escaping (InputContent.ViewConfig) -> Content
    ) {
        self.init(
            provider: provider,
            headerItem: headerItem
        )
        
        // list
        self.viewConverter.list.tableView.entireContent = ViewConverter { tableViewConfig in
            UIHostingController(rootView: list(tableViewConfig)).view
        }
        self.viewConverter.list.tableView.viewUpdateHandlers[.entireContent] = { viewController in
            viewController.listComponent?.applyViewConverter(.entireContent)
        }
        
        // input
        self.viewConverter.input.entireContent = ViewConverter { inputViewConfig in
            UIHostingController(rootView: input(inputViewConfig)).view
        }
        
        self.viewConverter.input.viewUpdateHandlers[.entireContent] = { viewController in
            viewController.inputComponent?.applyViewConverter(.entireContent)
        }
        
        self.applyViewConverterSet()
    }
}

// MARK: Event handler interfaces
public extension GroupChannelView {
    /// Called when an error occurs.
    func onSendbirdError(_ errorHandler: @escaping SendbirdErrorHandler) -> Self {
        let copy = self
        copy.provider.eventHandlers.errorHandler = errorHandler
        return copy
    }
}

#Preview {
    NavigationView {
        GroupChannelView(provider: .init(channelURL: ""))
    }
}
