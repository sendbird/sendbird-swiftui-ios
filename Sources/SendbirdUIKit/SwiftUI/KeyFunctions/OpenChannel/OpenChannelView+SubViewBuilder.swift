//
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import Foundation
import SendbirdChatSDK

// MARK: - Typealias
/// A typealias for a closure that builds a `OpenChannelSettingsView`.
public typealias OpenChannelViewBuilder = (
    _ channelURL: String,
    _ messageListParams: MessageListParams?
) -> OpenChannelView

// MARK: - Extension: ViewBuilder
public extension OpenChannelView {
    /// Configures the open channel settings view with the provided content.
    func channelSettingsView(_ content: @escaping OpenChannelSettingsViewBuilder) -> Self {
        var copy = self
        let config = { (viewController: SBUOpenChannelViewController) in
            viewController.channelSettingsViewBuilder = content
        }
        
        copy.configurations.append(config)
        return copy
    }
    
    /// Configures the user list view with the provided content.
    func participantListView(_ content: @escaping OpenParticipantListViewBuilder) -> Self {
        var copy = self
        let config = { (viewController: SBUOpenChannelViewController) in
            viewController.participantListViewBuilder = content
        }
        
        copy.configurations.append(config)
        return copy
    }
}
