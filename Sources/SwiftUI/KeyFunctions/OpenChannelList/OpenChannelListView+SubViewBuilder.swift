//
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import Foundation
import SendbirdChatSDK

// MARK: - Typealias
/// A typealias for a closure that builds a `OpenChannelView`.
public typealias OpenChannelListViewBuilder = () -> OpenChannelListView

// MARK: - Extension: ViewBuilder
public extension OpenChannelListView {
    /// Configures the open channel view with the provided content.
    func openChannelView(_ content: @escaping OpenChannelViewBuilder) -> Self {
        var copy = self
        let config = { (viewController: SBUOpenChannelListViewController) in
            viewController.openChannelViewBuilder = content
        }
        
        copy.configurations.append(config)
        return copy
    }
    
    /// Configures the create open channel view with the provided content.
    func createChannelView(_ content: @escaping CreateOpenChannelViewBuilder) -> Self {
        var copy = self
        let config = { (viewController: SBUOpenChannelListViewController) in
            viewController.createChannelViewBuilder = content
        }
        
        copy.configurations.append(config)
        return copy
    }
}
