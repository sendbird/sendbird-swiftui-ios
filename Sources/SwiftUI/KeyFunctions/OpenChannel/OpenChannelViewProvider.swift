//
//  OpenChannelViewProvider.swift
//  SendbirdUIKit
//
//  Created by Celine Moon on 10/22/24.
//

import Foundation
import SwiftUI
import SendbirdChatSDK

/// Event handlers for the Open Channel view.
public struct OpenChannelEventHandlers {
    var errorHandler: SendbirdErrorHandler?
    var connectionStateChangeHandler: SendbirdConnectionStateChangeHandler?
}

/// A provider that manages data and state for the Open Channel view.
public class OpenChannelViewProvider: SendbirdUIProvider {
    // SendbirdProvider protocol
    weak var viewController: SBUOpenChannelViewController?
    var eventHandlers = OpenChannelEventHandlers()
    
    // init properties
    /// The channel URL for the current channel.
    public private(set) var channelURL: String
    /// The starting point timestamp for loading messages.
    public private(set) var startingPoint: Int64?
    /// The message list parameters used to filter messages.
    public private(set) var messageListParams: MessageListParams?

    // MARK: Published properties
    /// The current open channel object.
    @Published public var channel: OpenChannel?
    /// The list of messages in the channel.
    @Published public var fullMessages: [BaseMessage] = []
    /// Indicates whether the view is currently loading.
    @Published public var isLoading: Bool = false
    
    // MARK: Private properties
    fileprivate var viewModel: SBUOpenChannelViewModel? {
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
    /// Navigates back from the channel screen.
    func onClickBack() {
        self.viewController?.onClickBack()
    }

    /// Presents the channel settings screen.
    func showChannelSettings() {
        self.viewController?.showChannelSettings()
    }

    /// Presents the participants list screen.
    func showParticipantsList() {
        self.viewController?.showParticipantsList()
    }
}

// MARK: - ViewModel method wrappers
public extension OpenChannelViewProvider {
    /// Loads older messages preceding the current list.
    func loadPreviousMessages() {
        viewModel?.loadPrevMessages(timestamp: .max)
    }

    /// Loads newer messages following the current list.
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
        initialLoad: Bool,
        isEventMessageReceived: Bool
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
