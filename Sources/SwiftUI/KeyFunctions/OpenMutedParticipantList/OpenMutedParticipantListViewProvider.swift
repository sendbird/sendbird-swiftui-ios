//
//  OpenMutedParticipantListViewProvider.swift
//  SendbirdUIKit
//
//  Created by Tez Park on 10/22/24.
//

import Foundation
import SwiftUI
import SendbirdChatSDK

// MARK: ViewEventHandlers
public struct OpenMutedParticipantListViewEventHandlers {
    // Blocks for handling for user inputs.
    var selectRowHandler: ((_ indexPath: IndexPath) -> Void)?
    
    // Blocks for handling for internal events.
    var errorHandler: ((_ error: SBError?) -> Void)?
}

// MARK: - OpenMutedParticipantListViewProvider
public class OpenMutedParticipantListViewProvider: SendbirdUIProvider {
    // MARK: - Init properties
    public var channelURL: String
    var customUsers: [SBUUser]?
    
    // SendbirdProvider protocol
    weak var viewController: SBUUserListViewController?
    var eventHandlers = OpenMutedParticipantListViewEventHandlers()
    
    // MARK: Public Data Properties
    /// Muted participant list
    @Published public var mutedParticipants: [SBUUser] = []
    
    /// Channel object
    @Published public var channel: OpenChannel?
    
    /// Loading state
    @Published public var isLoading: Bool = false
    
    // MARK: Public UI Properties

    // MARK: Methods
    public init(
        channelURL: String,
        customUsers: [SBUUser]? = nil
    ) {
        self.channelURL = channelURL
        self.customUsers = customUsers
    }
    
    /// This function sets up the provider.
    @discardableResult
    public func setup(
        channelURL: String,
        customUsers: [SBUUser]? = nil
    ) -> Self {
        self.channelURL = channelURL
        if let customUsers { self.customUsers = customUsers }
        return self
    }
    
    func bind(viewController: SBUUserListViewController) {
        viewController.swiftUIDelegate = self
        self.viewController = viewController
    }
    
    // MARK: UIKit method wrappers

    /// This function shows the user profile
    /// - Parameter user: `SBUUser` object used for user profile configuration
    public func showUserProfile(user: SBUUser) {
        self.viewController?.showUserProfile(with: user)
    }
    
    /// This function shows the more menu
    public func showMoreMenu(user: SBUUser) {
        self.viewController?.showMoreMenu(with: user)
    }
    
    /// This function loads the muted participant list.
    public func loadNextMutedParticipantList(customUsers: [SBUUser]? = nil) {
        self.viewController?.viewModel?.loadNextUserList(reset: false, users: customUsers)
    }
    
    /// This function resets the muted participant list.
    public func resetMutedParticipantList(customUsers: [SBUUser]? = nil) {
        self.viewController?.viewModel?.loadNextUserList(reset: true, users: customUsers)
    }

    /// This function mutes the user.
    public func mute(user: SBUUser) {
        self.viewController?.viewModel?.mute(user: user)
    }

    /// This function unmutes the user.
    public func unmute(user: SBUUser) {
        self.viewController?.viewModel?.unmute(user: user)
    }
}

// MARK: - ViewEventDelegate
extension OpenMutedParticipantListViewProvider: UserListViewEventDelegate {
    func userListView(didSelectRowAt indexPath: IndexPath) {
        self.eventHandlers.selectRowHandler?(indexPath)
    }
}

// MARK: - ViewModelDelegate
extension OpenMutedParticipantListViewProvider: SBUUserListViewModelDelegate {
    public func userListViewModel(
        _ viewModel: SBUUserListViewModel,
        didChangeUsers users: [SBUUser],
        needsToReload: Bool
    ) {
        StateImpactHandler.safeExecute { [weak self] in
            self?.mutedParticipants = users
        }
    }
    
    public func userListViewModel(
        _ viewModel: SBUUserListViewModel,
        didChangeChannel channel: SendbirdChatSDK.BaseChannel?,
        withContext context: SendbirdChatSDK.MessageContext
    ) {
        StateImpactHandler.safeExecute { [weak self] in
            self?.channel = channel as? OpenChannel
        }
    }
    
    public func userListViewModel(
        _ viewModel: SBUUserListViewModel,
        shouldDismissForUserList channel: SendbirdChatSDK.BaseChannel?
    ) {
        // TODO:
    }
}

extension OpenMutedParticipantListViewProvider: SBUCommonViewModelDelegate {
    public func shouldUpdateLoadingState(_ isLoading: Bool) {
        StateImpactHandler.safeExecute { [weak self] in
            self?.isLoading = isLoading
        }
    }
    
    public func didReceiveError(_ error: SendbirdChatSDK.SBError?, isBlocker: Bool) {
        self.eventHandlers.errorHandler?(error)
    }
}
