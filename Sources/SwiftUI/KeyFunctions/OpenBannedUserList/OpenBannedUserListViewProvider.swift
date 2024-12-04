//
//  OpenBannedUserListViewProvider.swift
//  SendbirdUIKit
//
//  Created by Tez Park on 10/22/24.
//

import Foundation
import SwiftUI
import SendbirdChatSDK

// MARK: ViewEventHandlers
public struct OpenBannedUserListViewEventHandlers {
    // Blocks for handling for user inputs.
    var selectRowHandler: ((_ indexPath: IndexPath) -> Void)?
    
    // Blocks for handling for internal events.
    var errorHandler: ((_ error: SBError?) -> Void)?
}

// MARK: - OpenBannedUserListViewProvider
public class OpenBannedUserListViewProvider: SendbirdUIProvider {
    // MARK: - Init properties
    public var channelURL: String
    var customUsers: [SBUUser]?
    
    // MARK: - Internal properties
    weak var viewController: SBUUserListViewController?
    var eventHandlers = OpenBannedUserListViewEventHandlers()
    
    // MARK: Public Data Properties
    /// Banned user list
    @Published public var bannedUsers: [SBUUser] = []
    
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
    
    /// This function loads the banned user list.
    public func loadNextBannedUserList(customUsers: [SBUUser]? = nil) {
        self.viewController?.viewModel?.loadNextUserList(reset: false, users: customUsers)
    }
    
    /// This function resets the user list.
    public func resetBannedUserList(customUsers: [SBUUser]? = nil) {
        self.viewController?.viewModel?.loadNextUserList(reset: true, users: customUsers)
    }

    /// This function bans the user.
    public func ban(user: SBUUser) {
        self.viewController?.viewModel?.ban(user: user)
    }

    /// This function unbans the user.
    public func unban(user: SBUUser) {
        self.viewController?.viewModel?.unban(user: user)
    }
}

// MARK: - ViewEventDelegate
extension OpenBannedUserListViewProvider: UserListViewEventDelegate {
    func userListView(didSelectRowAt indexPath: IndexPath) {
        self.eventHandlers.selectRowHandler?(indexPath)
    }
}

// MARK: - ViewModelDelegate
extension OpenBannedUserListViewProvider: SBUUserListViewModelDelegate {
    public func userListViewModel(
        _ viewModel: SBUUserListViewModel,
        didChangeUsers users: [SBUUser],
        needsToReload: Bool
    ) {
        StateImpactHandler.safeExecute { [weak self] in
            self?.bannedUsers = users
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

extension OpenBannedUserListViewProvider: SBUCommonViewModelDelegate {
    public func shouldUpdateLoadingState(_ isLoading: Bool) {
        StateImpactHandler.safeExecute { [weak self] in
            self?.isLoading = isLoading
        }
    }
    
    public func didReceiveError(_ error: SendbirdChatSDK.SBError?, isBlocker: Bool) {
        self.eventHandlers.errorHandler?(error)
    }
}
