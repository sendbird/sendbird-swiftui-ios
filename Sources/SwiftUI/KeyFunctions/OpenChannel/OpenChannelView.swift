//
//  OpenChannelView.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SwiftUI
import SendbirdChatSDK

/// A view that displays a OpenChannel
public struct OpenChannelView: View {
    // MARK: - Properties
    @Environment(\.dismiss)
    private var dismiss
    
    var configurations: [(SBUOpenChannelViewController) -> Void] = []
    
    // Non-optional since `channelURL` is required.
    @ObservedObject var provider: OpenChannelViewProvider
    
    init(provider: OpenChannelViewProvider) {
        self.provider = provider  // Default
    }
    
    /// The content and behavior of the view.
    public var body: some View {
        SBUViewControllerSet.OpenChannelViewController
            .swiftUI {
                createViewController()
            }
            .injectData { viewController in
                if self.shouldUpdateData(viewController: viewController) {
                    // Inject data into view model and load
                    viewController.viewModel?.initializeAndLoad(
                        channelURL: self.provider.channelURL,
                        messageListParams: self.provider.messageListParams,
                        startingPoint: self.provider.startingPoint
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
                    SBViewConverterSet.OpenChannel = OpenChannelViewConverter()
                }
            }
    }
    
    // MARK: - Methods
    private func createViewController() -> SBUOpenChannelViewController {
        Log.info(
            """
            [\(Self.self).\(#function)] provider
            channelURL = \(provider.channelURL)
            startingPoint = \(String(describing: provider.startingPoint))
            messageListParams = \(String(describing: provider.messageListParams))
            """
        )
        
        let viewController = SBUViewControllerSet.OpenChannelViewController.init(
            channelURL: self.provider.channelURL,
            startingPoint: self.provider.startingPoint,
            messageListParams: self.provider.messageListParams
        )
        
        self.provider.bind(viewController: viewController)
        
        return viewController
    }
    
    private func shouldUpdateData(viewController: SBUOpenChannelViewController) -> Bool {
        let shouldUpdateChannelURL = viewController.viewModel?.channelURL == "" && self.provider.channelURL != ""
        let shouldUpdateMessageListParams = viewController.viewModel?.customizedMessageListParams == nil && self.provider.messageListParams != nil
        let shouldUpdateStartingPoint = viewController.viewModel?.startingPoint == nil && self.provider.startingPoint != nil
        return shouldUpdateChannelURL || shouldUpdateMessageListParams || shouldUpdateStartingPoint
    }
}

// MARK: - Initializers
/// OpenChannelView initializers
public extension OpenChannelView {
    // MARK: - typealias
    /// The list content type alias for OpenChannelView.
    typealias ListContent = OpenChannelViewConverter.List
    /// The input content type alias for OpenChannelView.
    typealias InputContent = OpenChannelViewConverter.Input

    /// Initializes a new view with the given parameters.
    init(
        provider: OpenChannelViewProvider,
        headerItem: (() -> OpenChannelType.HeaderItem)? = nil,
        listItem: (() -> OpenChannelType.ListItem)? = nil,
        inputItem: (() -> OpenChannelType.InputItem)? = nil
    ) {
        self.init(provider: provider)
        
        if let headerItem { _ = headerItem() }
        if let listItem { _ = listItem() }
        if let inputItem { _ = inputItem() }
        
        self.applyViewConverterSet()
    }
    
    // TODO: After entire content is implemented
    internal init<Content: View>(
        provider: OpenChannelViewProvider,
        headerItem: (() -> OpenChannelType.HeaderItem)? = nil,
        list: @escaping (ListContent.TableView.ViewConfig) -> Content,
        inputItem: (() -> OpenChannelType.InputItem)? = nil
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
        provider: OpenChannelViewProvider,
        headerItem: (() -> OpenChannelType.HeaderItem)? = nil,
        listItem: (() -> OpenChannelType.ListItem)? = nil,
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
    private init<Content: View>(
        provider: OpenChannelViewProvider,
        headerItem: (() -> OpenChannelType.HeaderItem)? = nil,
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

#Preview {
    NavigationView {
        OpenChannelView(provider: .init(channelURL: ""))
    }
}
