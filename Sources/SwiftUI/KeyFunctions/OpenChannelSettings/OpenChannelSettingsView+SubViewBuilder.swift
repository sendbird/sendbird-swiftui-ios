//
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import Foundation
import SendbirdChatSDK

// MARK: - Typealias

/// A typealias for a closure that builds a `OpenChannelSettingsViewBuilder`.
public typealias OpenChannelSettingsViewBuilder = (
    _ channelURL: String
) -> OpenChannelSettingsView

// MARK: - Extension
public extension OpenChannelSettingsView {
    /// Configures the open channel user list view with the provided content.
    func participantListView(_ content: @escaping OpenParticipantListViewBuilder) -> Self {
        var copy = self
        let config = { (viewController: SBUOpenChannelSettingsViewController) in
            viewController.participantListViewBuilder = content
        }
        
        copy.configurations.append(config)
        return copy
    }
    
    /// Configures the open channel moderations view with the provided content.
    func moderationsView(_ content: @escaping OpenModerationsViewBuilder) -> Self {
        var copy = self
        let config = { (viewController: SBUOpenChannelSettingsViewController) in
            viewController.moderationsViewBuilder = content
        }
        
        copy.configurations.append(config)
        return copy
    }
}
