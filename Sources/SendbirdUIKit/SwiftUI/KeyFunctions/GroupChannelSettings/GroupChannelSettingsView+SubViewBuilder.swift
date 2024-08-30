//
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import Foundation
import SendbirdChatSDK

// MARK: - Typealias
/// A typealias for a closure that builds a `GroupChannelSettingsView`.
public typealias GroupChannelSettingsViewBuilder = (
    _ channelURL: String
) -> GroupChannelSettingsView

// MARK: - Extension: ViewBuilder
public extension GroupChannelSettingsView {
    /// Configures the group channel user list view with the provided content.
    func memberListView(_ content: @escaping GroupMemberListViewBuilder) -> Self {
        var copy = self
        let config = { (viewController: SBUGroupChannelSettingsViewController) in
            viewController.memberListViewBuilder = content
        }
        
        copy.configurations.append(config)
        return copy
    }
    
    /// Configures the group channel moderations view with the provided content.
    func moderationsView(_ content: @escaping GroupModerationsViewBuilder) -> Self {
        var copy = self
        let config = { (viewController: SBUGroupChannelSettingsViewController) in
            viewController.moderationsViewBuilder = content
        }
        
        copy.configurations.append(config)
        return copy
    }
    
    /// Configures the group channel push settings view with the provided content.
    func pushSettingsView(_ content: @escaping GroupChannelPushSettingsViewBuilder) -> Self {
        var copy = self
        let config = { (viewController: SBUGroupChannelSettingsViewController) in
            viewController.pushSettingsViewBuilder = content
        }
        
        copy.configurations.append(config)
        return copy
    }
    
    /// Configures the group channel message search view with the provided content.
    func messageSearchView(_ content: @escaping MessageSearchViewBuilder) -> Self {
        var copy = self
        let config = { (viewController: SBUGroupChannelSettingsViewController) in
            viewController.messageSearchViewBuilder = content
        }
        
        copy.configurations.append(config)
        return copy
    }
}
