//
//  InviteUserViewProvider.swift
//  SendbirdUIKit
//
//  Created by Celine Moon on 10/22/24.
//

import Foundation
import SwiftUI
import SendbirdChatSDK

/// A provider that manages data and state for the Invite User view.
public class InviteUserViewProvider: SendbirdUIProvider {
    // init properties
    var channelURL: String
    var customUsers: [SBUUser]?
    
    // SendbirdProvider protocol
    weak var viewController: SBUInviteUserViewController?
    var eventHandlers = InviteUserEventHandlers()
    
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
    
    func bind(viewController: SBUInviteUserViewController) {
        viewController.swiftUIDelegate = self
        self.viewController = viewController
    }
}

extension InviteUserViewProvider: SBUInviteUserViewModelDelegate {
    public func inviteUserViewModel(_ viewModel: SBUInviteUserViewModel, didInviteUserIds userIds: [String]) {
        
    }
    
    public func baseSelectedUserViewModel(_ viewModel: SBUBaseSelectUserViewModel, didChangeUserList users: [SBUUser]?, needsToReload: Bool) {
        
    }
    
    public func baseSelectedUserViewModel(_ viewModel: SBUBaseSelectUserViewModel, didUpdateSelectedUsers selectedUsers: [SBUUser]?) {
        
    }
    
    public func shouldUpdateLoadingState(_ isLoading: Bool) {
        
    }
    
    public func didReceiveError(_ error: SendbirdChatSDK.SBError?, isBlocker: Bool) {
        
    }
}

extension InviteUserViewProvider: InviteUserViewEventDelegate {
    
}

/// Event handlers for the Invite User view.
public struct InviteUserEventHandlers {

}
