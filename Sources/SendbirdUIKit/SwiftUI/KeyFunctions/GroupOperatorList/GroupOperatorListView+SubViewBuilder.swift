//
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import Foundation
import SendbirdChatSDK

// MARK: - Typealias
/// A typealias for a closure that builds a `GroupOperatorListViewBuilder`.
public typealias GroupOperatorListViewBuilder = (
    _ channelURL: String
) -> GroupOperatorListView

// MARK: - Extension: ViewBuilder
public extension GroupOperatorListView {
    /// Configures the group channel user list view with the provided content.
    func registerOperatorView(_ content: @escaping GroupChannelRegisterOperatorViewBuilder) -> Self {
        var copy = self
        let config = { (viewController: SBUUserListViewController) in
            viewController.groupChannelRegisterOperatorViewBuilder = content
        }
        
        copy.configurations.append(config)
        return copy
    }
}
