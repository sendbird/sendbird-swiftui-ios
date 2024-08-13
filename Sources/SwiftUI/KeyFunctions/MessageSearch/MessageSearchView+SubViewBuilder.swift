//
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import Foundation
import SendbirdChatSDK

// MARK: - Typealias
/// A typealias for a closure that builds a `MessageSearchView`.
public typealias MessageSearchViewBuilder = (
    _ channelURL: String
) -> MessageSearchView

// MARK: - Extension: ViewBuilder
public extension MessageSearchView {
    /// Configures the group channel view with the provided content.
    func groupChannelView(_ content: @escaping GroupChannelViewBuilder) -> Self {
        var copy = self
        let config = { (viewController: SBUMessageSearchViewController) in
            viewController.groupChannelViewBuilder = content
        }
        
        copy.configurations.append(config)
        return copy
    }
}
