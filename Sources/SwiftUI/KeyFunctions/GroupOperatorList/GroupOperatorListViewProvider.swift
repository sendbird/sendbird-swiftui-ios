//
//  GroupOperatorListViewProvider.swift
//  SendbirdUIKit
//
//  Created by Tez Park on 10/22/24.
//

import Foundation
import SwiftUI
import SendbirdChatSDK

// MARK: ViewEventHandlers
/// Event handlers for the Group Operator List view.
public struct GroupOperatorListViewEventHandlers {
    // Blocks for handling for user inputs.
    var selectRowHandler: ((_ indexPath: IndexPath) -> Void)?

    // Blocks for handling for internal events.
    var errorHandler: ((_ error: SBError?) -> Void)?
}

// MARK: - GroupOperatorListViewProvider
/// A provider that manages data and state for the Group Operator List view.
public class GroupOperatorListViewProvider: SendbirdUIProvider {
    // MARK: - Init properties
    public var channelURL: String
    var customUsers: [SBUUser]?
    
    // MARK: - Internal properties
    weak var viewController: SBUUserListViewController?
    var eventHandlers = GroupOperatorListViewEventHandlers()
    
    // MARK: Public Data Properties
    /// Operator list
    @Published public var operators: [SBUUser] = []
    
    /// Channel object
    @Published public var channel: GroupChannel?
    
    /// Loading state
    @Published public var isLoading: Bool = false
    
    // MARK: Public UI Properties

    // MARK: Methods
    /// Initializes a new provider with the given parameters.
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
    
    /// This function loads the operator list.
    public func loadNextOperatorList(customUsers: [SBUUser]? = nil) {
        self.viewController?.viewModel?.loadNextUserList(reset: false, users: customUsers)
    }
    
    /// This function resets the operator list.
    public func resetOperatorList(customUsers: [SBUUser]? = nil) {
        self.viewController?.viewModel?.loadNextUserList(reset: true, users: customUsers)
    }

    /// This function registers the user as an operator.
    public func registerAsOperator(user: SBUUser) {
        self.viewController?.viewModel?.registerAsOperator(user: user)
    }

    /// This function unregisters the user as an operator.
    public func unregisterOperator(user: SBUUser) {
        self.viewController?.viewModel?.unregisterOperator(user: user)
    }
}

// MARK: - ViewEventDelegate
extension GroupOperatorListViewProvider: UserListViewEventDelegate {
    func userListView(didSelectRowAt indexPath: IndexPath) {
        self.eventHandlers.selectRowHandler?(indexPath)
    }
}

// MARK: - ViewModelDelegate
extension GroupOperatorListViewProvider: SBUUserListViewModelDelegate {
    public func userListViewModel(
        _ viewModel: SBUUserListViewModel,
        didChangeUsers users: [SBUUser],
        needsToReload: Bool
    ) {
        StateImpactHandler.safeExecute { [weak self] in
            self?.operators = users
        }
    }
    
    public func userListViewModel(
        _ viewModel: SBUUserListViewModel,
        didChangeChannel channel: SendbirdChatSDK.BaseChannel?,
        withContext context: SendbirdChatSDK.MessageContext
    ) {
        StateImpactHandler.safeExecute { [weak self] in
            self?.channel = channel as? GroupChannel
        }
    }
    
    public func userListViewModel(
        _ viewModel: SBUUserListViewModel,
        shouldDismissForUserList channel: SendbirdChatSDK.BaseChannel?
    ) {
        // TODO:
    }
}

extension GroupOperatorListViewProvider: SBUCommonViewModelDelegate {
    public func shouldUpdateLoadingState(_ isLoading: Bool) {
        StateImpactHandler.safeExecute { [weak self] in
            self?.isLoading = isLoading
        }
    }
    
    public func didReceiveError(_ error: SendbirdChatSDK.SBError?, isBlocker: Bool) {
        self.eventHandlers.errorHandler?(error)
    }
}
