//
//  CreateGroupChannelViewProvider.swift
//  SendbirdUIKit
//
//  Created by Celine Moon on 10/22/24.
//

import Foundation
import SwiftUI
import SendbirdChatSDK

// MARK: - ViewEventHandlers
public struct CreateGroupChannelEventHandlers {
    // Blocks for handling for user inputs.
    var selectRowHandler: ((_ indexPath: IndexPath) -> Void)?
    
    // Blocks for handling for internal events.
    var errorHandler: ((_ error: SBError?) -> Void)?
}

// MARK: - CreateGroupChannelViewProvider
public class CreateGroupChannelViewProvider: SendbirdUIProvider {
    // init properties
    var customUsers: [SBUUser]?
    var type: ChannelCreationType = .group
    
    // SendbirdUIProvider properties
    weak var viewController: SBUCreateChannelViewController?
    var eventHandlers = CreateGroupChannelEventHandlers()
    
    // MARK: Public Data Properties
    /// User list
    @Published public var users: [SBUUser] = []
    
    /// Selected users
    @Published public var selectedUsers: [SBUUser] = []
    
    /// Loading state
    @Published public var isLoading: Bool = false
    
    // MARK: Public UI Properties

    // MARK: Methods
    public init(
        customUsers: [SBUUser]? = nil,
        type: ChannelCreationType = .group
    ) {
        self.type = type
        self.customUsers = customUsers
    }
    
    /// This function sets up the provider.
    @discardableResult
    public func setup(
        customUsers: [SBUUser]? = nil,
        type: ChannelCreationType? = nil
    ) -> Self {
        if let customUsers { self.customUsers = customUsers }
        if let type { self.type = type }
        return self
    }
    
    func bind(viewController: SBUCreateChannelViewController) {
        viewController.swiftUIDelegate = self
        self.viewController = viewController
    }
    
    // MARK: UIKit method wrappers
    
    /// Create a channel with selected users.
    public func createChannelWithSelectedUsers() {
        self.viewController?.createChannelWithSelectedUsers()
    }
    
    /// Creates the channel with channelParams.
    ///
    /// You can create a channel by setting various properties of ChannelParams.
    /// - Parameters:
    ///   - params: `GroupChannelCreateParams` class object
    ///   - messageListParams: If there is a messageListParams set directly for use in Channel, set it up here
    public func createChannel(
        params: GroupChannelCreateParams,
        messageListParams: MessageListParams? = nil
    ) {
        self.viewController?.viewModel?.createChannel(
            params: params,
            messageListParams: messageListParams
        )
    }
    
    /// Load the user list.
    /// - Parameters:
    ///  - customUsers: Custom user list to load (optional)
    public func loadNextUserList(customUsers: [SBUUser]?) {
        self.viewController?.viewModel?.loadNextUserList(
            reset: false,
            users: customUsers
        )
    }
    
    /// Resets the user list.
    public func resetUserList() {
        self.viewController?.viewModel?.resetUserList()
    }
}

// MARK: - ViewEventDelegate
extension CreateGroupChannelViewProvider: SBUCreateChannelViewModelDelegate {
    public func createChannelViewModel(
        _ viewModel: SBUCreateChannelViewModel,
        didChangeUsers users: [SBUUser],
        needsToReload: Bool
    ) { 
        StateImpactHandler.safeExecute { [weak self] in
            self?.users = users
        }
    }
    
    /// Called when it has created channel with `MessageListParams` object.
    public func createChannelViewModel(
        _ viewModel: SBUCreateChannelViewModel,
        didCreateChannel channel: BaseChannel?,
        withMessageListParams messageListParams: MessageListParams?
    ) { }
    
    /// Called when the selected users has been updated.
    public func createChannelViewModel(
        _ viewModel: SBUCreateChannelViewModel,
        didUpdateSelectedUsers selectedUsers: [SBUUser]
    ) { 
        StateImpactHandler.safeExecute { [weak self] in
            self?.selectedUsers = selectedUsers
        }
    }
}

// MARK: - ViewModelDelegate
extension CreateGroupChannelViewProvider: CreateGroupChannelViewEventDelegate {
    func createGroupChannelView(didSelectRowAt indexPath: IndexPath) {
        self.eventHandlers.selectRowHandler?(indexPath)
    }
}

extension CreateGroupChannelViewProvider: SBUCommonViewModelDelegate {
    public func shouldUpdateLoadingState(_ isLoading: Bool) {
        StateImpactHandler.safeExecute { [weak self] in
            self?.isLoading = isLoading
        }
    }
    
    public func didReceiveError(_ error: SendbirdChatSDK.SBError?, isBlocker: Bool) {
        self.eventHandlers.errorHandler?(error)
    }
}

// MARK: - ViewModelDelegate (default implementation)
extension SBUCreateChannelViewModelDelegate {
    
}
