//
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import Foundation
import SendbirdChatSDK

// MARK: - Typealias
/// A typealias for a closure that builds a `GroupModerationsView`.
public typealias GroupModerationsViewBuilder = (
    _ channelURL: String
) -> GroupModerationsView

// MARK: - Extension: ViewBuilder
public extension GroupModerationsView {
    /// Configures the group channel operator list view with the provided
    func operatorListView(_ content: @escaping GroupOperatorListViewBuilder) -> Self {
        var copy = self
        let config = { (viewController: SBUModerationsViewController) in
            viewController.groupOperatorListViewBuilder = content
        }
        
        copy.configurations.append(config)
        return copy
    }
    
    /// Configures the group channel muted member list view with the provided
    func mutedMemberListView(_ content: @escaping GroupMutedMemberListViewBuilder) -> Self {
        var copy = self
        let config = { (viewController: SBUModerationsViewController) in
            viewController.groupMutedMemberListViewBuilder = content
        }
        
        copy.configurations.append(config)
        return copy
    }
    
    /// Configures the group channel banned user list view with the provided
    func bannedUserListView(_ content: @escaping GroupBannedUserListViewBuilder) -> Self {
        var copy = self
        let config = { (viewController: SBUModerationsViewController) in
            viewController.groupBannedUserListViewBuilder = content
        }
        
        copy.configurations.append(config)
        return copy
    }
}
