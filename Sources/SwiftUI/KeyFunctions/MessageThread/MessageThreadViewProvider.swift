//
//  MessageThreadViewProvider.swift
//  SendbirdUIKit
//
//  Created by Celine Moon on 10/21/24.
//

import Foundation
import SwiftUI
import SendbirdChatSDK

public struct MessageThreadViewEventHandlers {
    // Blocks for handling for internal events.
    var errorHandler: ((_ error: SBError?) -> Void)?
}

public class MessageThreadViewProvider: SendbirdUIProvider {
    // SendbirdUIProvider protocol
    weak var viewController: SBUMessageThreadViewController?
    var eventHandlers = MessageThreadViewEventHandlers()
    
    //
    public private(set) var channelURL: String
    public private(set) var parentMessageId: Int64
    public private(set) var threadedMessageListParams: ThreadedMessageListParams?
    public private(set) var startingPoint: Int64? = .max
    public private(set) var voiceFileInfos: [String: SBUVoiceFileInfo]?
    
    // MARK: Published properties
    @Published public var channel: BaseChannel?
    @Published public var parentMessage: BaseMessage?
    @Published public var fullMessages: [BaseMessage] = []
    @Published public var isLoading: Bool = false
    
    public init(
        channelURL: String,
        parentMessageId: Int64,
        threadedMessageListParams: ThreadedMessageListParams? = nil,
        startingPoint: Int64? = .max,
        voiceFileInfos: [String: SBUVoiceFileInfo]? = nil
    ) {
        self.channelURL = channelURL
        self.parentMessageId = parentMessageId
        self.threadedMessageListParams = threadedMessageListParams
        self.startingPoint = startingPoint
        self.voiceFileInfos = voiceFileInfos
    }
    
    /// This function sets up the provider.
    @discardableResult
    public func setup(
        channelURL: String,
        parentMessageId: Int64,
        threadedMessageListParams: ThreadedMessageListParams? = nil,
        startingPoint: Int64? = .max,
        voiceFileInfos: [String: SBUVoiceFileInfo]? = nil
    ) -> Self {
        self.channelURL = channelURL
        self.parentMessageId = parentMessageId
        if let threadedMessageListParams {self.threadedMessageListParams = threadedMessageListParams }
        if let startingPoint {self.startingPoint = startingPoint }
        if let voiceFileInfos {self.voiceFileInfos = voiceFileInfos }
        return self
    }
    
    func bind(viewController: SBUMessageThreadViewController) {
        viewController.swiftUIDelegate = self
        self.viewController = viewController
    }
}

// MARK: - SBUMessageThreadViewModelDelegate
extension MessageThreadViewProvider: SBUMessageThreadViewModelDelegate {
    public func messageThreadViewModel(
        _ viewModel: SBUMessageThreadViewModel,
        didReceiveSuggestedMentions members: [SBUUser]?
    ) {
        
    }
    
    public func messageThreadViewModel(
        _ viewModel: SBUMessageThreadViewModel,
        didLoadParentMessage parentMessage: BaseMessage?
    ) {
        if let parentMessage = parentMessage {
            StateImpactHandler.safeExecute { [weak self] in
                self?.parentMessage = parentMessage
            }
        }
    }
    
    public func messageThreadViewModel(
        _ viewModel: SBUMessageThreadViewModel,
        didUpdateParentMessage parentMessage: BaseMessage?
    ) {
        if let parentMessage = parentMessage {
            StateImpactHandler.safeExecute { [weak self] in
                self?.parentMessage = parentMessage
            }
        }
    }
    
    public func messageThreadViewModelShouldDismissMessageThread(
        _ viewModel: SBUMessageThreadViewModel
    ) {
        
    }
    
    public func messageThreadViewModel(
        _ viewModel: SBUMessageThreadViewModel,
        didFinishUploadingFileAt index: Int,
        multipleFilesMessageRequestId requestId: String
    ) {
        
    }
    
    public func baseChannelViewModel(
        _ viewModel: SBUBaseChannelViewModel,
        didChangeChannel channel: BaseChannel?,
        withContext context: MessageContext
    ) {
        if let channel {
            StateImpactHandler.safeExecute { [weak self] in
                self?.channel = channel
            }
        }
    }
    
    public func baseChannelViewModel(
        _ viewModel: SBUBaseChannelViewModel,
        didReceiveNewMessage message: BaseMessage,
        forChannel channel: BaseChannel
    ) {
        
    }
    
    public func baseChannelViewModel(
        _ viewModel: SBUBaseChannelViewModel,
        shouldFinishEditModeForChannel channel: BaseChannel
    ) {
        
    }
    
    public func baseChannelViewModel(
        _ viewModel: SBUBaseChannelViewModel,
        shouldDismissForChannel channel: BaseChannel?
    ) {
        
    }
    
    public func baseChannelViewModel(
        _ viewModel: SBUBaseChannelViewModel,
        didChangeMessageList messages: [BaseMessage],
        needsToReload: Bool,
        initialLoad: Bool,
        isEventMessageReceived: Bool
    ) {
        StateImpactHandler.safeExecute { [weak self] in
            self?.fullMessages = messages
        }
    }
    
    public func baseChannelViewModel(
        _ viewModel: SBUBaseChannelViewModel,
        deletedMessages messages: [BaseMessage]
    ) {
        
    }
    
    public func baseChannelViewModel(
        _ viewModel: SBUBaseChannelViewModel,
        shouldUpdateScrollInMessageList messages: [BaseMessage],
        forContext context: MessageContext?,
        keepsScroll: Bool
    ) {
        
    }
    
    public func baseChannelViewModel(
        _ viewModel: SBUBaseChannelViewModel,
        didUpdateReaction reaction: ReactionEvent,
        forMessage message: BaseMessage
    ) {
        
    }
}

// MARK: - SBUCommonViewModelDelegate
extension MessageThreadViewProvider: SBUCommonViewModelDelegate {
    public func shouldUpdateLoadingState(_ isLoading: Bool) {
        StateImpactHandler.safeExecute { [weak self] in
            self?.isLoading = isLoading
        }
    }
    
    public func didReceiveError(_ error: SendbirdChatSDK.SBError?, isBlocker: Bool) {
        self.eventHandlers.errorHandler?(error)
    }
}

// MARK: - MessageThreadViewEventDelegate
extension MessageThreadViewProvider: MessageThreadViewEventDelegate {
    
}
