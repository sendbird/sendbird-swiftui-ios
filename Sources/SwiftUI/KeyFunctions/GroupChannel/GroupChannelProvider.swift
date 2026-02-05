//
//  GroupChannelViewProvider.swift
//  SendbirdUIKit
//
//  Created by Celine Moon on 10/21/24.
//

import Foundation
import SwiftUI
import SendbirdChatSDK

public struct GroupChannelViewEventHandlers {
    // Internal state event handlers.
    var errorHandler: SendbirdErrorHandler?
    var connectionStateChangeHandler: SendbirdConnectionStateChangeHandler?
}

public class GroupChannelViewProvider: SendbirdUIProvider {
    public private(set) var channelURL: String
    public private(set) var startingPoint: Int64?
    var messageListParams: MessageListParams?
    
    weak var viewController: SBUGroupChannelViewController?
    var eventHandlers = GroupChannelViewEventHandlers()
    
    // MARK: Published properties
    @Published public var channel: GroupChannel?
    @Published public var fullMessages: [BaseMessage] = []
    @Published public var isLoading: Bool = false
    @Published public var newMessagesCount: Int = 0
    @Published public var messageInputText: String?
    
    // MARK: Computed properties
    public var hasNext: Bool {
        self.viewController?.viewModel?.hasNext() ?? false
    }
    
    public var hasPrevious: Bool {
        self.viewController?.viewModel?.hasPrevious() ?? false
    }
    
    public var highlightInfo: SBUHighlightMessageInfo? {
        self.viewController?.highlightInfo
    }
    
    // MARK: Private properties
    fileprivate var messageInputView: SBUMessageInputView? { self.viewController?.inputComponent?.messageInputView as? SBUMessageInputView
    }
    
    fileprivate var viewModel: SBUGroupChannelViewModel? {
        self.viewController?.viewModel
    }
    
    public init(
        channelURL: String,
        startingPoint: Int64? = nil,
        messageListParams: MessageListParams? = nil
    ) {
        self.channelURL = channelURL
        self.startingPoint = startingPoint
        self.messageListParams = messageListParams
    }

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
    func showChannelSettings() {
        self.viewController?.showChannelSettings()
    }
    
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
    
    func showResourcePicker() {
        messageInputView?.onTapAddButton()
    }
    
    func showCamera() {
        messageInputView?.showCamera()
    }
    
    func showPhotosLibrary() {
        messageInputView?.showPhotosLibrary()
    }
    
    func showDocumentsPicker() {
        messageInputView?.showDocumentsPicker()
    }
    
    // View Model Methods
    func sendUserMessage(
        messageParams: UserMessageCreateParams,
        parentMessage: BaseMessage? = nil
    ) {
        self.viewController?.viewModel?.sendUserMessage(
            messageParams: messageParams,
            parentMessage: parentMessage
        )
    }
    
    func sendFileMessage(
        messageParams: FileMessageCreateParams,
        parentMessage: BaseMessage? = nil
    ) {
        self.viewController?.viewModel?.sendFileMessage(
            messageParams: messageParams,
            parentMessage: parentMessage
        )
    }
    
    func resendMessage(failedMessage: BaseMessage) {
        viewModel?.resendMessage(failedMessage: failedMessage)
    }
    
    func deleteMessage(message: BaseMessage) {
        viewModel?.deleteMessage(message: message)
    }
    
    func clearMessageList() {
        viewModel?.clearMessageList()
    }
    
    func setReaction(message: BaseMessage, emojiKey: String, didSelect: Bool) {
        viewModel?.setReaction(message: message, emojiKey: emojiKey, didSelect: didSelect)
    }
    
    func loadPrevMessages() {
        viewModel?.loadPrevMessages()
    }
    
    func loadNextMessages() {
        viewModel?.loadNextMessages()
    }
    
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
