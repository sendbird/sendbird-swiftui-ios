//
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import Foundation
import SendbirdChatSDK
// MARK: - Typealias

/// A typealias for a closure that builds a `GroupChannelView`.
public typealias GroupChannelViewBuilder = (
    _ channelURL: String,
    _ startingPoint: Int64?,
    _ messageListParams: MessageListParams?
) -> GroupChannelView

// MARK: - Extension: ViewBuilder
public extension GroupChannelView {
    /// Configures the group channel settings view with the provided content.
    func channelSettingsView(_ content: @escaping GroupChannelSettingsViewBuilder) -> Self {
        var copy = self
        let config = { (viewController: SBUGroupChannelViewController) in
            viewController.channelSettingsViewBuilder = content
        }

        copy.configurations.append(config)
        return copy
    }
    
    /// Configures the message thread view with the provided content.
    func messageThreadView(_ content: @escaping MessageThreadViewBuilder) -> Self {
        var copy = self
        let config = { (viewController: SBUGroupChannelViewController) in
            viewController.messageThreadViewBuilder = content
        }

        copy.configurations.append(config)
        return copy
    }
}
