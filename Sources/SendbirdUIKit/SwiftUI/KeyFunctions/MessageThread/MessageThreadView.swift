//
//  MessageThreadView.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SwiftUI
import SendbirdChatSDK

/// A view that displays a MessageThread
public struct MessageThreadView: View {
    // MARK: - Properties
    @Environment(\.dismiss)
    private var dismiss
    
    var configurations: [(SBUMessageThreadViewController) -> Void] = []
    
    private var channelURL: String
    private var parentMessageId: Int64
    private var delegate: SBUMessageThreadViewControllerDelegate?
    private var threadedMessageListParams: ThreadedMessageListParams?
    private var startingPoint: Int64? = .max
    private var voiceFileInfos: [String: SBUVoiceFileInfo]? = nil
    
    // MARK: - Methods
    public var body: some View {
        SBUViewControllerSet.MessageThreadViewController
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
    
    private func createViewController() -> SBUMessageThreadViewController {
        let viewController = SBUViewControllerSet.MessageThreadViewController.init(
            channelURL: self.channelURL,
            parentMessageId: self.parentMessageId,
            delegate: self.delegate,
            threadedMessageListParams: self.threadedMessageListParams,
            startingPoint: self.startingPoint,
            voiceFileInfos: self.voiceFileInfos
        )
        return viewController
    }
}

// MARK: - Initializers
/// MessageThreadView initializers
public extension MessageThreadView {
    // MARK: - typealias
    typealias ListContent = MessageThreadViewConverter.List
    typealias InputContent = MessageThreadViewConverter.Input
    
    init(
        channelURL: String,
        parentMessageId: Int64,
        delegate: SBUMessageThreadViewControllerDelegate? = nil,
        threadedMessageListParams: ThreadedMessageListParams? = nil,
        startingPoint: Int64? = .max,
        voiceFileInfos: [String: SBUVoiceFileInfo]? = nil
    ) {
        self.channelURL = channelURL
        self.parentMessageId = parentMessageId
        self.delegate = delegate
        self.threadedMessageListParams = threadedMessageListParams
        self.startingPoint = startingPoint
        self.voiceFileInfos = voiceFileInfos
        
        // Apply view converter in viewConverterSet.
        self.applyViewConverterSet()
    }
    
    init(
        channelURL: String,
        parentMessageId: Int64,
        delegate: SBUMessageThreadViewControllerDelegate? = nil,
        threadedMessageListParams: ThreadedMessageListParams? = nil,
        startingPoint: Int64? = .max,
        voiceFileInfos: [String: SBUVoiceFileInfo]? = nil,
        headerItem: (() -> MessageThreadType.HeaderItem)? = nil,
        parentInfoItem: (() -> MessageThreadType.ParentInfoItem)? = nil,
        listItem: (() -> MessageThreadType.ListItem)? = nil,
        inputItem: (() -> MessageThreadType.InputItem)? = nil
    ) {
        self.init(
            channelURL: channelURL,
            parentMessageId: parentMessageId,
            delegate: delegate,
            threadedMessageListParams: threadedMessageListParams,
            startingPoint: startingPoint,
            voiceFileInfos: voiceFileInfos
        )

        if let headerItem { _ = headerItem() }
        if let parentInfoItem { _ = parentInfoItem() }
        if let listItem { _ = listItem() }
        if let inputItem { _ = inputItem() }

        // Apply view converter in viewConverterSet.
        self.applyViewConverterSet()
    }

    init<Content: View>(
        channelURL: String,
        parentMessageId: Int64,
        delegate: SBUMessageThreadViewControllerDelegate? = nil,
        threadedMessageListParams: ThreadedMessageListParams? = nil,
        startingPoint: Int64? = .max,
        voiceFileInfos: [String: SBUVoiceFileInfo]? = nil,
        headerItem: (() -> MessageThreadType.HeaderItem)? = nil,
        list: @escaping (ListContent.TableView.ViewConfig) -> Content,
        inputItem: (() -> MessageThreadType.InputItem)? = nil
    ) {
        self.init(
            channelURL: channelURL,
            parentMessageId: parentMessageId,
            delegate: delegate,
            threadedMessageListParams: threadedMessageListParams,
            startingPoint: startingPoint,
            voiceFileInfos: voiceFileInfos,
            headerItem: headerItem,
            inputItem: inputItem
        )

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
        parentMessageId: Int64,
        delegate: SBUMessageThreadViewControllerDelegate? = nil,
        threadedMessageListParams: ThreadedMessageListParams? = nil,
        startingPoint: Int64? = .max,
        voiceFileInfos: [String: SBUVoiceFileInfo]? = nil,
        headerItem: (() -> MessageThreadType.HeaderItem)? = nil,
        parentInfoItem: (() -> MessageThreadType.ParentInfoItem)? = nil,
        listItem: (() -> MessageThreadType.ListItem)? = nil,
        input: @escaping (InputContent.ViewConfig) -> Content
    ) {
        self.init(
            channelURL: channelURL,
            parentMessageId: parentMessageId,
            delegate: delegate,
            threadedMessageListParams: threadedMessageListParams,
            startingPoint: startingPoint,
            voiceFileInfos: voiceFileInfos,
            headerItem: headerItem,
            parentInfoItem: parentInfoItem,
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
        parentMessageId: Int64,
        delegate: SBUMessageThreadViewControllerDelegate? = nil,
        threadedMessageListParams: ThreadedMessageListParams? = nil,
        startingPoint: Int64? = .max,
        voiceFileInfos: [String: SBUVoiceFileInfo]? = nil,
        headerItem: (() -> MessageThreadType.HeaderItem)? = nil,
        list: @escaping (ListContent.TableView.ViewConfig) -> Content,
        input: @escaping (InputContent.ViewConfig) -> Content
    ) {
        self.init(
            channelURL: channelURL,
            parentMessageId: parentMessageId,
            delegate: delegate,
            threadedMessageListParams: threadedMessageListParams,
            startingPoint: startingPoint,
            voiceFileInfos: voiceFileInfos,
            headerItem: headerItem
        )

        self.viewConverter.list.tableView.entireContent = ViewConverter { tableViewConfig in
            UIHostingController(rootView: list(tableViewConfig)).view
        }
        self.viewConverter.list.tableView.viewUpdateHandlers[.entireContent] = { viewController in
            viewController.listComponent?.applyViewConverter(.entireContent)
        }
        
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
}

#Preview {
    NavigationView {
        MessageThreadView(channelURL: "", parentMessageId: -1)
    }
}
