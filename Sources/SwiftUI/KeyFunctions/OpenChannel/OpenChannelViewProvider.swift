//
//  OpenChannelViewProvider.swift
//  SendbirdUIKit
//
//  Created by Celine Moon on 10/22/24.
//

import Foundation
import SwiftUI
import SendbirdChatSDK

public struct OpenChannelEventHandlers {
    var errorHandler: SendbirdErrorHandler?
    var connectionStateChangeHandler: SendbirdConnectionStateChangeHandler?
}

public class OpenChannelViewProvider: SendbirdUIProvider {
    // SendbirdProvider protocol
    weak var viewController: SBUOpenChannelViewController?
    var eventHandlers = OpenChannelEventHandlers()
    
    // init properties
    public private(set) var channelURL: String
    public private(set) var startingPoint: Int64?
    public private(set) var messageListParams: MessageListParams?
    
    // MARK: Published properties
    @Published public var channel: OpenChannel?
    @Published public var fullMessages: [BaseMessage] = []
    @Published public var isLoading: Bool = false
    
    // MARK: Private properties
    fileprivate var viewModel: SBUOpenChannelViewModel? {
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
    
    /// This function sets up the provider.
    @discardableResult
    public func setup(
        channelURL: String,
        startingPoint: Int64? = nil,
        messageListParams: MessageListParams? = nil
    ) -> Self {
        self.channelURL = channelURL
        if let startingPoint { self.startingPoint = startingPoint }
        if let messageListParams { self.messageListParams = messageListParams }
        return self
    }
    
    func bind(viewController: SBUOpenChannelViewController) {
        viewController.swiftUIDelegate = self
        self.viewController = viewController
    }
}

// MARK: - ViewController method wrappers
public extension OpenChannelViewProvider {
    func onClickBack() {
        self.viewController?.onClickBack()
    }
    
    func showChannelSettings() {
        self.viewController?.showChannelSettings()
    }
    
    func showParticipantsList() {
        self.viewController?.showParticipantsList()
    }
}

// MARK: - ViewModel method wrappers
public extension OpenChannelViewProvider {
    func loadPreviousMessages() {
        viewModel?.loadPrevMessages(timestamp: .max)
    }
    
    func loadNextMessages() {
        viewModel?.loadNextMessages()
    }
}

// MARK: - SBUOpenChannelViewModelDelegate
extension OpenChannelViewProvider: SBUOpenChannelViewModelDelegate {
    public func baseChannelViewModel(
        _ viewModel: SBUBaseChannelViewModel,
        didChangeChannel channel: BaseChannel?,
        withContext context: MessageContext
    ) {
        if let openChannel = channel as? OpenChannel {
            StateImpactHandler.safeExecute { [weak self] in
                self?.channel = openChannel
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
        initialLoad: Bool
    ) {
        StateImpactHandler.safeExecute { [weak self] in
            self?.fullMessages = messages
        }
    }
    
    public func baseChannelViewModel(
        _ viewModel: SBUBaseChannelViewModel,
        deletedMessages messages: [SendbirdChatSDK.BaseMessage]
    ) {
        
    }
    
    public func baseChannelViewModel(
        _ viewModel: SBUBaseChannelViewModel,
        shouldUpdateScrollInMessageList messages: [SendbirdChatSDK.BaseMessage],
        forContext context: SendbirdChatSDK.MessageContext?,
        keepsScroll: Bool
    ) {
        
    }
    
    public func baseChannelViewModel(
        _ viewModel: SBUBaseChannelViewModel,
        didUpdateReaction reaction: SendbirdChatSDK.ReactionEvent,
        forMessage message: SendbirdChatSDK.BaseMessage
    ) {
        
    }
}

// MARK: SBUCommonViewModelDelegate
extension OpenChannelViewProvider: SBUCommonViewModelDelegate {
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

// MARK: - OpenChannelViewEventDelegate
extension OpenChannelViewProvider: OpenChannelViewEventDelegate {
    
}
