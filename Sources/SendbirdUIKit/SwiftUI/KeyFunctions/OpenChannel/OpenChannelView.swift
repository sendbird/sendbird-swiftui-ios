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
    
    private var channelURL: String
    private var startingPoint: Int64?
    private var messageListParams: MessageListParams?
    
    // MARK: - Methods
    public var body: some View {
        SBUViewControllerSet.OpenChannelViewController
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
    
    private func createViewController() -> SBUOpenChannelViewController {
        let viewController = SBUViewControllerSet.OpenChannelViewController.init(
            channelURL: self.channelURL,
            startingPoint: self.startingPoint,
            messageListParams: self.messageListParams
        )
        return viewController
    }
}

// MARK: - Initializers
/// OpenChannelView initializers
public extension OpenChannelView {
    // MARK: - typealias
    typealias ListContent = OpenChannelViewConverter.List
    typealias InputContent = OpenChannelViewConverter.Input
    
    init(
        channelURL: String,
        startingPoint: Int64? = nil,
        messageListParams: MessageListParams? = nil
    ) {
        self.channelURL = channelURL
        self.startingPoint = startingPoint
        self.messageListParams = messageListParams
        
        // Apply view converter in viewConverterSet.
        self.applyViewConverterSet()
    }

    init(
        channelURL: String,
        startingPoint: Int64? = nil,
        messageListParams: MessageListParams? = nil,
        headerItem: (() -> OpenChannelType.HeaderItem)? = nil,
        listItem: (() -> OpenChannelType.ListItem)? = nil,
        inputItem: (() -> OpenChannelType.InputItem)? = nil
    ) {
        self.init(
            channelURL: channelURL,
            startingPoint: startingPoint,
            messageListParams: messageListParams
        )
        
        if let headerItem { _ = headerItem() }
        if let listItem { _ = listItem() }
        if let inputItem { _ = inputItem() }
        
        self.applyViewConverterSet()
    }
    
    init<Content: View>(
        channelURL: String,
        startingPoint: Int64? = nil,
        messageListParams: MessageListParams? = nil,
        headerItem: (() -> OpenChannelType.HeaderItem)? = nil,
        list: @escaping (ListContent.TableView.ViewConfig) -> Content,
        inputItem: (() -> OpenChannelType.InputItem)? = nil
    ) {
        self.init(
            channelURL: channelURL,
            startingPoint: startingPoint,
            messageListParams: messageListParams,
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
        channelURL: String,
        startingPoint: Int64? = nil,
        messageListParams: MessageListParams? = nil,
        headerItem: (() -> OpenChannelType.HeaderItem)? = nil,
        listItem: (() -> OpenChannelType.ListItem)? = nil,
        input: @escaping (InputContent.ViewConfig) -> Content
    ) {
        self.init(
            channelURL: channelURL,
            startingPoint: startingPoint,
            messageListParams: messageListParams,
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
        channelURL: String,
        startingPoint: Int64? = nil,
        messageListParams: MessageListParams? = nil,
        headerItem: (() -> OpenChannelType.HeaderItem)? = nil,
        list: @escaping (ListContent.TableView.ViewConfig) -> Content,
        input: @escaping (InputContent.ViewConfig) -> Content
    ) {
        self.init(
            channelURL: channelURL,
            startingPoint: startingPoint,
            messageListParams: messageListParams,
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
        OpenChannelView(channelURL: "")
    }
}
