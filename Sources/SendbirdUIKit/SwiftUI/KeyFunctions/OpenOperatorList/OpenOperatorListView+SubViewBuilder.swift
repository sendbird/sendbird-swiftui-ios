//
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import Foundation
import SendbirdChatSDK

// MARK: - Typealias
/// A typealias for a closure that builds a `OpenOperatorListViewBuilder`.
public typealias OpenOperatorListViewBuilder = (
    _ channelURL: String
) -> OpenOperatorListView

// MARK: - Extension: ViewBuilder
public extension OpenOperatorListView {
    /// Configures the Open channel user list view with the provided content.
    func registerOperatorView(_ content: @escaping OpenChannelRegisterOperatorViewBuilder) -> Self {
        var copy = self
        let config = { (viewController: SBUUserListViewController) in
            viewController.openChannelRegisterOperatorViewBuilder = content
        }
        
        copy.configurations.append(config)
        return copy
    }
}
