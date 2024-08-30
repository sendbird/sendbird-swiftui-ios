//
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import Foundation
import SendbirdChatSDK

// MARK: - Typealias
/// A typealias for a closure that builds a `GroupMemberListViewBuilder`.
public typealias GroupMemberListViewBuilder = (
    _ channelURL: String
) -> GroupMemberListView

// MARK: - Extension: ViewBuilder
public extension GroupMemberListView {
    /// Configures the invitel user view with the provided content.
    func inviteUserView(_ content: @escaping InviteUserViewBuilder) -> Self {
        var copy = self
        let config = { (viewController: SBUUserListViewController) in
            viewController.inviteUserViewBuilder = content
        }
        
        copy.configurations.append(config)
        return copy
    }
}
