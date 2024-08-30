//
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import Foundation
import SendbirdChatSDK

// MARK: - Typealias

/// A typealias for a closure that builds a `OpenModerationsView`.
public typealias OpenModerationsViewBuilder = (
    _ channelURL: String
) -> OpenModerationsView

// MARK: - Extension: ViewBuilder
public extension OpenModerationsView {
    /// Configures the open channel operator list view with the provided
    func operatorListView(_ content: @escaping OpenOperatorListViewBuilder) -> Self {
        var copy = self
        let config = { (viewController: SBUModerationsViewController) in
            viewController.openOperatorListViewBuilder = content
        }
        
        copy.configurations.append(config)
        return copy
    }
    
    /// Configures the open channel muted member list view with the provided
    func mutedParticipantListView(_ content: @escaping OpenMutedParticipantListViewBuilder) -> Self {
        var copy = self
        let config = { (viewController: SBUModerationsViewController) in
            viewController.openMutedParticipantListViewBuilder = content
        }
        
        copy.configurations.append(config)
        return copy
    }
    
    /// Configures the open channel banned user list view with the provided
    func bannedUserListView(_ content: @escaping OpenBannedUserListViewBuilder) -> Self {
        var copy = self
        let config = { (viewController: SBUModerationsViewController) in
            viewController.openBannedUserListViewBuilder = content
        }
        
        copy.configurations.append(config)
        return copy
    }

}
