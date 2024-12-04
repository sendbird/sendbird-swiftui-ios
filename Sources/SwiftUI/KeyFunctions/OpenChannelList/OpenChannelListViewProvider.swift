//
//  OpenChannelListViewProvider.swift
//  SendbirdUIKit
//
//  Created by Celine Moon on 10/22/24.
//

import Foundation
import SwiftUI
import SendbirdChatSDK

public struct OpenChannelListEventHandlers {
    // View related event handlers.
    var selectRowHandler: ((_ indexPath: IndexPath) -> Void)?
    
    // Internal state event handerls.
    var connectionStateChangeHandler: SendbirdConnectionStateChangeHandler?
    var errorHandler: SendbirdErrorHandler?
}

public class OpenChannelListViewProvider: SendbirdUIProvider {
    // SendbirdProvider protocol
    weak var viewController: SBUOpenChannelListViewController?
    var eventHandlers = OpenChannelListEventHandlers()
    
    // init properties
    var channelListQuery: OpenChannelListQuery?
    
    // Published properties
    @Published public var channels: [OpenChannel] = []
    @Published public var isLoading: Bool = false
    
    public init(channelListQuery: OpenChannelListQuery? = nil) {
        self.channelListQuery = channelListQuery
    }
    
    /// This function sets up the provider.
    @discardableResult
    public func setup(
        channelListQuery: OpenChannelListQuery? = nil
    ) -> Self {
        if let channelListQuery { self.channelListQuery = channelListQuery }
        return self
    }
    
    func bind(viewController: SBUOpenChannelListViewController) {
        viewController.swiftUIDelegate = self
        self.viewController = viewController
    }
}

// MARK: ViewController method wrappers
public extension OpenChannelListViewProvider {
    func reloadChannelList() {
        self.viewController?.reloadChannelList()
    }
    
    func showChannel(channelURL: String, messageListParams: MessageListParams? = nil) {
        self.viewController?.showChannel(channelURL: channelURL, messageListParams: messageListParams)
    }
    
    func showCreateChannel() {
        self.viewController?.showCreateChannel()
    }
}

// MARK: ViewModel method wrappers
public extension OpenChannelListViewProvider {
    // MARK: - List handling
    func loadNextChannelList() {
        self.viewController?.viewModel?.loadNextChannelList(reset: true)
    }
}

// MARK: SBUOpenChannelListViewModelDelegate
extension OpenChannelListViewProvider: SBUOpenChannelListViewModelDelegate {
    public func openChannelListViewModel(
        _ viewModel: SBUOpenChannelListViewModel,
        didChangeChannelList channels: [OpenChannel]?,
        needsToReload: Bool
    ) {
        if let channels {
            StateImpactHandler.safeExecute { [weak self] in
                self?.channels = channels
            }
        }
    }
    
    public func openChannelListViewModel(
        _ viewModel: SBUOpenChannelListViewModel,
        didUpdateChannel channel: OpenChannel
    ) {
        if let index = self.channels.firstIndex(where: { $0.channelURL == channel.channelURL }) {
            StateImpactHandler.safeExecute { [weak self] in
                self?.channels[index] = channel
            }
        }
    }
    
    public func didReceiveError(_ error: SBError?, isBlocker: Bool) {
        self.eventHandlers.errorHandler?(error)
    }
}

extension OpenChannelListViewProvider: SBUCommonViewModelDelegate {
    public func connectionStateDidChange(_ isConnected: Bool) {
        self.eventHandlers.connectionStateChangeHandler?(isConnected)
    }
    
    public func didreceiveError(_ error: SBError?) {
        self.eventHandlers.errorHandler?(error)
    }
    
    public func shouldUpdateLoadingState(_ isLoading: Bool) {
        StateImpactHandler.safeExecute { [weak self] in
            self?.isLoading = isLoading
        }
    }
}

// MARK: OpenChannelListViewEventDelegate
extension OpenChannelListViewProvider: OpenChannelListViewEventDelegate {
    func openChannelListView(didSelectRowAt indexPath: IndexPath) {
        self.eventHandlers.selectRowHandler?(indexPath)
    }
}
