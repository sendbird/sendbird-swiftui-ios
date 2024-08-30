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
    
    private var channelURL: String
    private var startingPoint: Int64?
    private var messageListParams: MessageListParams?

    // for message search
    var highlightInfo: SBUHighlightMessageInfo?
    var useRightBarButtonItem: Bool = true
    
    // MARK: - Methods
    public var body: some View {
        SBUViewControllerSet.GroupChannelViewController
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
    
    private func createViewController() -> SBUGroupChannelViewController {
        let viewController = SBUViewControllerSet.GroupChannelViewController.init(
            channelURL: self.channelURL,
            startingPoint: self.startingPoint,
            messageListParams: self.messageListParams
        )
        viewController.highlightInfo = self.highlightInfo
        viewController.useRightBarButtonItem = self.useRightBarButtonItem
        
        return viewController
    }
}

// MARK: - Initializers
/// GroupChannelView initializers
public extension GroupChannelView {
    // MARK: - typealias
    typealias ListContent = GroupChannelViewConverter.List
    typealias InputContent = GroupChannelViewConverter.Input
    
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
        headerItem: (() -> GroupChannelType.HeaderItem)? = nil,
        listItem: (() -> GroupChannelType.ListItem)? = nil,
        inputItem: (() -> GroupChannelType.InputItem)? = nil
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
        headerItem: (() -> GroupChannelType.HeaderItem)? = nil,
        list: @escaping (ListContent.TableView.ViewConfig) -> Content,
        inputItem: (() -> GroupChannelType.InputItem)? = nil
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
        headerItem: (() -> GroupChannelType.HeaderItem)? = nil,
        listItem: (() -> GroupChannelType.ListItem)? = nil,
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
        headerItem: (() -> GroupChannelType.HeaderItem)? = nil,
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
        GroupChannelView(channelURL: "")
    }
}
