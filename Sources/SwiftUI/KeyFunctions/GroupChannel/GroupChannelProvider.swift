//
//  GroupChannelViewProvider.swift
//  SendbirdUIKit
//
//  Created by Celine Moon on 10/21/24.
//

import Foundation
import SwiftUI
import SendbirdChatSDK

/// Event handlers for the Group Channel view.
public struct GroupChannelViewEventHandlers {
    // Internal state event handlers.
    var errorHandler: SendbirdErrorHandler?
    var connectionStateChangeHandler: SendbirdConnectionStateChangeHandler?
}

/// A provider that manages data and state for the Group Channel view.
public class GroupChannelViewProvider: SendbirdUIProvider {
    /// The channel URL for the current channel.
    public private(set) var channelURL: String
    /// The starting point timestamp for loading messages.
    public private(set) var startingPoint: Int64?
    var messageListParams: MessageListParams?
    
    weak var viewController: SBUGroupChannelViewController?
    var eventHandlers = GroupChannelViewEventHandlers()
    
    // MARK: Published properties
    /// The current group channel object.
    @Published public var channel: GroupChannel?
    /// The list of messages in the channel.
    @Published public var fullMessages: [BaseMessage] = []
    /// Indicates whether the view is currently loading.
    @Published public var isLoading: Bool = false
    /// The count of new messages received since the last read.
    @Published public var newMessagesCount: Int = 0
    /// The current text in the message input field.
    @Published public var messageInputText: String?

    // MARK: Computed properties
    /// Indicates whether there are more recent messages to load.
    public var hasNext: Bool {
        self.viewController?.viewModel?.hasNext() ?? false
    }

    /// Indicates whether there are older messages to load.
    public var hasPrevious: Bool {
        self.viewController?.viewModel?.hasPrevious() ?? false
    }

    /// The highlight info for a specific message, if any.
    public var highlightInfo: SBUHighlightMessageInfo? {
        self.viewController?.highlightInfo
    }
    
    // MARK: Private properties
    fileprivate var messageInputView: SBUMessageInputView? { self.viewController?.inputComponent?.messageInputView as? SBUMessageInputView
    }
    
    fileprivate var viewModel: SBUGroupChannelViewModel? {
        self.viewController?.viewModel
    }
    
    /// Initializes a new provider with the given parameters.
    public init(
        channelURL: String,
        startingPoint: Int64? = nil,
        messageListParams: MessageListParams? = nil
    ) {
        self.channelURL = channelURL
        self.startingPoint = startingPoint
        self.messageListParams = messageListParams
    }

    /// Reconfigures the provider with updated channel parameters.
    public func setup(
        channelURL: String,
        startingPoint: Int64? = nil,
        messageListParams: MessageListParams? = nil
    ) {
        self.channelURL = channelURL
        if let startingPoint { self.startingPoint = startingPoint }
        if let messageListParams { self.messageListParams = messageListParams }
    }
    
    func bind(viewController: SBUGroupChannelViewController) {
        viewController.swiftUIDelegate = self
        self.viewController = viewController
    }
}

// MARK: - Method Wrappers
public extension GroupChannelViewProvider {
    // View Controller Methods
    /// Presents the channel settings screen.
    func showChannelSettings() {
        self.viewController?.showChannelSettings()
    }

    /// Presents the message thread screen for the specified parent message.
    func showMessageThread(
        parentMessageId: Int64,
        parentMessageCreatedAt: Int64, // 기존 인터페이스는 default 0인데, 그러면 작동X. default 없는게 사용할때 더 명확한듯.
        startingPoint: Int64? = 0
    ) {
        self.viewController?.showMessageThread(
            channelURL: self.channelURL,
            parentMessageId: parentMessageId,
            parentMessageCreatedAt: parentMessageCreatedAt,
            startingPoint: startingPoint
        )
    }
    
    /// Ends the typing mode of the Input View.
    func endTypingMode() {
        messageInputView?.endTypingMode()
    }
    
    /// Presents the resource picker for attaching files or media.
    func showResourcePicker() {
        messageInputView?.onTapAddButton()
    }

    /// Presents the camera for capturing a photo or video.
    func showCamera() {
        messageInputView?.showCamera()
    }

    /// Presents the photos library picker.
    func showPhotosLibrary() {
        messageInputView?.showPhotosLibrary()
    }

    /// Presents the documents picker.
    func showDocumentsPicker() {
        messageInputView?.showDocumentsPicker()
    }

    // View Model Methods
    /// Sends a user text message with the given parameters.
    func sendUserMessage(
        messageParams: UserMessageCreateParams,
        parentMessage: BaseMessage? = nil
    ) {
        self.viewController?.viewModel?.sendUserMessage(
            messageParams: messageParams,
            parentMessage: parentMessage
        )
    }
    
    /// Sends a file message with the given parameters.
    func sendFileMessage(
        messageParams: FileMessageCreateParams,
        parentMessage: BaseMessage? = nil
    ) {
        self.viewController?.viewModel?.sendFileMessage(
            messageParams: messageParams,
            parentMessage: parentMessage
        )
    }

    /// Resends a previously failed message.
    func resendMessage(failedMessage: BaseMessage) {
        viewModel?.resendMessage(failedMessage: failedMessage)
    }

    /// Deletes the specified message from the channel.
    func deleteMessage(message: BaseMessage) {
        viewModel?.deleteMessage(message: message)
    }

    /// Clears all messages from the local message list.
    func clearMessageList() {
        viewModel?.clearMessageList()
    }

    /// Sets or removes a reaction on the specified message.
    func setReaction(message: BaseMessage, emojiKey: String, didSelect: Bool) {
        viewModel?.setReaction(message: message, emojiKey: emojiKey, didSelect: didSelect)
    }

    /// Loads older messages preceding the current list.
    func loadPrevMessages() {
        viewModel?.loadPrevMessages()
    }

    /// Loads newer messages following the current list.
    func loadNextMessages() {
        viewModel?.loadNextMessages()
    }

    /// Reloads the entire message list from the current starting point.
    func reloadMessageList() {
        viewModel?.reloadMessageList()
    }
}

// MARK: - SBUGroupChannelViewModelDelegate
extension GroupChannelViewProvider: SBUGroupChannelViewModelDelegate {
    public func groupChannelViewModel(
        _ viewModel: SBUGroupChannelViewModel,
        didReceiveSuggestedMentions members: [SBUUser]?
    ) {
        
    }
    
    public func groupChannelViewModel(
        _ viewModel: SBUGroupChannelViewModel,
        didFinishUploadingFileAt index: Int,
        multipleFilesMessageRequestId requestId: String
    ) {
        
    }
    
    public func groupChannelViewModel(
        _ viewModel: SBUGroupChannelViewModel,
        didReceiveStreamMessage message: BaseMessage,
        forChannel channel: GroupChannel
    ) {
        
    }
    
    public func baseChannelViewModel(
        _ viewModel: SBUBaseChannelViewModel,
        didChangeChannel channel: BaseChannel?,
        withContext context: MessageContext
    ) {
        if let groupChannel = channel as? GroupChannel {
            StateImpactHandler.safeExecute { [weak self] in
                self?.channel = groupChannel
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
    
    // changes fullMessageList
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
extension GroupChannelViewProvider: SBUCommonViewModelDelegate {
    public func shouldUpdateLoadingState(_ isLoading: Bool) {
        StateImpactHandler.safeExecute { [weak self] in
            self?.isLoading = isLoading
        }
    }
    
    public func didReceiveError(_ error: SBError?, isBlocker: Bool) {
        self.eventHandlers.errorHandler?(error)
    }
    
    public func connectionStateDidChange(_ isConnected: Bool) {
        self.eventHandlers.connectionStateChangeHandler?(isConnected)
    }
}

// MARK: - GroupChannelViewEventDelegate
extension GroupChannelViewProvider: GroupChannelViewEventDelegate {
    func groupChannelViewDidUpdateNewMessagesCount(_ count: Int) {
        StateImpactHandler.safeExecute { [weak self] in
            self?.newMessagesCount = count
        }
    }
    
    func groupChannelViewDidChangeMessageText(_ text: String) {
        StateImpactHandler.safeExecute { [weak self] in
            self?.messageInputText = text
        }
    }
}
