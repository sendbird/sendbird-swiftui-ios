//
//  GroupChannelListViewProvider.swift
//  SendbirdUIKit
//
//  Created by Celine Moon on 10/28/24.
//

import Foundation
import SwiftUI
import SendbirdChatSDK

// MARK: GroupChannelListEventHandlers
/// Event handlers for the Group Channel List view.
public struct GroupChannelListEventHandlers {
    // View related event handlers.
    var selectRowHandler: ((_ indexPath: IndexPath) -> Void)?
    var selectLeaveChannelHandler: ((_ channel: GroupChannel) -> Void)?
    var changePushTriggerOptionHandler: ((_ channel: GroupChannel) -> Void)?

    // Internal state event handlers.
    var connectionStateChangeHandler: SendbirdConnectionStateChangeHandler?
    var errorHandler: SendbirdErrorHandler?

    // Note: Events from Chat SDK are not be available in SendbirdSwiftUI.
}

// MARK: - GroupChannelListViewProvider
/// A provider that manages data and state for the Group Channel List view.
public class GroupChannelListViewProvider: SendbirdUIProvider {
    // Init properties
    var channelListQuery: GroupChannelListQuery?
    
    // SendbirdProvider protocol
    weak var viewController: SBUGroupChannelListViewController?
    var eventHandlers = GroupChannelListEventHandlers()
    
    // MARK: Public Data Properties
    // Note: @Published properties can't be computed properties.
    /// The list of group channels.
    @Published public var channels: [GroupChannel] = []
    /// Indicates whether the view is currently loading.
    @Published public var isLoading: Bool = false

    // MARK: Public UI Properties (??)
    // public var theme: SBUGroupChannelListTheme

    /// Initializes a new provider with the given parameters.
    public init(channelListQuery: GroupChannelListQuery? = nil) {
        self.channelListQuery = channelListQuery
    }

    /// This function sets up the provider.
    @discardableResult
    public func setup(
        channelListQuery: GroupChannelListQuery? = nil
    ) -> Self {
        if let channelListQuery { self.channelListQuery = channelListQuery }
        return self
    }
    
    func bind(viewController: SBUGroupChannelListViewController) {
        viewController.swiftUIDelegate = self
        self.viewController = viewController
    }
}

// MARK: - ViewController method wrappers
extension GroupChannelListViewProvider {
    /// Navigates to the channel with the given URL.
    public func showChannel(
        channelURL: String,
        messageListParams: MessageListParams? = nil
    ) {
        self.viewController?.showChannel(
            channelURL: channelURL,
            messageListParams: messageListParams
        )
    }
    
    /// Presents the create channel screen or a type selector if multiple channel types are available.
    public func showCreateChannelOrTypeSelector () {
        self.viewController?.showCreateChannelOrTypeSelector()
    }

    /// Presents the channel type selector screen.
    public func showCreateChannelTypeSelector() {
        self.viewController?.showCreateChannelTypeSelector()
    }

    /// Presents the create channel screen for the specified channel type.
    public func showCreateChannel(type: ChannelCreationType = .group) {
        self.viewController?.showCreateChannel(type: type)
    }

    /// Presents the default create group channel screen.
    public func showCreateChannel() {
        self.viewController?.showCreateChannel()
    }
}

// MARK: - ViewModel method wrappers
extension GroupChannelListViewProvider {
    // MARK: - List handling
    func loadNextChannelList() {
        self.viewController?.viewModel?.loadNextChannelList(reset: true)
    }
}

// MARK: - GroupChannelListViewModelDelegate
extension GroupChannelListViewProvider: SBUGroupChannelListViewModelDelegate {
    public func groupChannelListViewModel(
        _ viewModel: SBUGroupChannelListViewModel,
        didUpdateChannel channel: GroupChannel
    ) {
        StateImpactHandler.safeExecute { [weak self] in
            if let index = self?.channels.firstIndex(where: { $0.channelURL == channel.channelURL }) {
                self?.channels[index] = channel
            }
        }
    }
    
    public func groupChannelListViewModel(
        _ viewModel: SBUGroupChannelListViewModel,
        didLeaveChannel channel: GroupChannel
    ) {
        
    }
    
    public func shouldUpdateLoadingState(_ isLoading: Bool) {
        StateImpactHandler.safeExecute { [weak self] in
            self?.isLoading = isLoading
        }
    }
    
    public func groupChannelListViewModel(_ viewModel: SBUGroupChannelListViewModel, didChangeChannelList channels: [GroupChannel]?, needsToReload: Bool) {
        guard let channels = channels else { return }
        StateImpactHandler.safeExecute { [weak self] in
            self?.channels = channels
        }
    }
}

// MARK: - CommonViewModelDelegate
extension GroupChannelListViewProvider: SBUCommonViewModelDelegate {
    public func connectionStateDidChange(_ isConnected: Bool) {
        self.eventHandlers.connectionStateChangeHandler?(isConnected)
    }
    
    public func didReceiveError(_ error: SBError?, isBlocker: Bool) {
        self.eventHandlers.errorHandler?(error)
    }
}

// MARK: - GroupChannelListViewEventDelegate
extension GroupChannelListViewProvider: GroupChannelListViewEventDelegate {
    func groupChannelListView(didSelectRowAt indexPath: IndexPath) {
        self.eventHandlers.selectRowHandler?(indexPath)
    }
    
    func groupChannelListView(didSelectLeaveFrom channel: GroupChannel) {
        self.eventHandlers.selectLeaveChannelHandler?(channel)
    }
    
    func groupChannelListView(didChangePushTriggerOption channel: GroupChannel) {
        self.eventHandlers.changePushTriggerOptionHandler?(channel)
    }
}
