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
    
    // Non-optional since `channelURL`, `parentMessageId` are required.
    @ObservedObject private var provider: MessageThreadViewProvider

    init(provider: MessageThreadViewProvider) {
        self.provider = provider  // Default
    }
    
    public var body: some View {
        SBUViewControllerSet.MessageThreadViewController
            .swiftUI {
                createViewController()
            }
            .injectData { viewController in
                if self.shouldUpdateData(viewController: viewController) {
                    // Inject data into view model and load
                    if let voiceFileInfos = provider.voiceFileInfos {
                        viewController.voiceFileInfos = voiceFileInfos
                    }
                    
                    viewController.viewModel?.initializeAndLoad(
                        channelURL: self.provider.channelURL,
                        parentMessageId: self.provider.parentMessageId,
                        threadedMessageListParams: self.provider.threadedMessageListParams,
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
                    SBViewConverterSet.MessageThread = MessageThreadViewConverter()
                }
            }
    }
    
    // MARK: - Methods
    private func createViewController() -> SBUMessageThreadViewController {
        let viewController = SBUViewControllerSet.MessageThreadViewController.init(
            channelURL: self.provider.channelURL,
            parentMessageId: self.provider.parentMessageId,
            threadedMessageListParams: self.provider.threadedMessageListParams,
            startingPoint: self.provider.startingPoint,
            voiceFileInfos: self.provider.voiceFileInfos
        )
        
        // connect VC, VM <-> provider
        self.provider.bind(viewController: viewController)
        return viewController
    }
    
    private func shouldUpdateData(viewController: SBUMessageThreadViewController) -> Bool {
        let shouldUpdateChannelURL = viewController.viewModel?.channelURL == "" && self.provider.channelURL != ""
        let shouldUpdateParentMessageId = viewController.viewModel?.parentMessageId == nil && self.provider.parentMessageId != 0
        let shouldUpdateStartingPoint = viewController.viewModel?.startingPoint == nil && self.provider.startingPoint != 0
        let shouldUpdateVoiceFileInfos = viewController.voiceFileInfos == nil && self.provider.voiceFileInfos != nil
        let shouldUpdateThreadMessageParams = viewController.viewModel?.threadedMessageListParams == nil && self.provider.threadedMessageListParams != nil
        
        return shouldUpdateChannelURL || shouldUpdateParentMessageId || shouldUpdateStartingPoint || shouldUpdateVoiceFileInfos || shouldUpdateThreadMessageParams
    }
}

// MARK: - Initializers
/// MessageThreadView initializers
public extension MessageThreadView {
    // MARK: - typealias
    typealias ListContent = MessageThreadViewConverter.List
    typealias InputContent = MessageThreadViewConverter.Input
    
    init(
        provider: MessageThreadViewProvider,
        headerItem: (() -> MessageThreadType.HeaderItem)? = nil,
        parentInfoItem: (() -> MessageThreadType.ParentInfoItem)? = nil,
        listItem: (() -> MessageThreadType.ListItem)? = nil,
        inputItem: (() -> MessageThreadType.InputItem)? = nil
    ) {
        self.init(provider: provider)

        if let headerItem { _ = headerItem() }
        if let parentInfoItem { _ = parentInfoItem() }
        if let listItem { _ = listItem() }
        if let inputItem { _ = inputItem() }

        // Apply view converter in viewConverterSet.
        self.applyViewConverterSet()
    }

    // TODO: After entire content is implemented
    internal init<Content: View>(
        provider: MessageThreadViewProvider,
        headerItem: (() -> MessageThreadType.HeaderItem)? = nil,
        list: @escaping (ListContent.TableView.ViewConfig) -> Content,
        inputItem: (() -> MessageThreadType.InputItem)? = nil
    ) {
        self.init(provider: provider)

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
        provider: MessageThreadViewProvider,
        headerItem: (() -> MessageThreadType.HeaderItem)? = nil,
        parentInfoItem: (() -> MessageThreadType.ParentInfoItem)? = nil,
        listItem: (() -> MessageThreadType.ListItem)? = nil,
        input: @escaping (InputContent.ViewConfig) -> Content
    ) {
        self.init(
            provider: provider,
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
        provider: MessageThreadViewProvider,
        headerItem: (() -> MessageThreadType.HeaderItem)? = nil,
        list: @escaping (ListContent.TableView.ViewConfig) -> Content,
        input: @escaping (InputContent.ViewConfig) -> Content
    ) {
        self.init(
            provider: provider,
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
        MessageThreadView(
            provider: .init(
                channelURL: "",
                parentMessageId: -1
            )
        )
    }
}
