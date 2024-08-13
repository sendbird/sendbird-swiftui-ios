//
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SwiftUI
import SendbirdChatSDK

// MARK: - Typealias
/// A typealias for a closure that builds a `GroupChannelListView`.
public typealias GroupChannelListViewBuilder = () -> GroupChannelListView

// MARK: - Extension: ViewBuilder
public extension GroupChannelListView {
    /// Configures the group channel view with the provided content.
    func groupChannelView(_ content: @escaping GroupChannelViewBuilder) -> Self {
        var copy = self
        let config = { (viewController: SBUGroupChannelListViewController) in
            viewController.groupChannelViewBuilder = content
        }
        
        copy.configurations.append(config)
        return copy
    }
    
    /// Configures the create group channel view with the provided content.
    func createChannelView(_ content: @escaping CreateGroupChannelViewBuilder) -> Self {
        var copy = self
        let config = { (viewController: SBUGroupChannelListViewController) in
            viewController.createChannelViewBuilder = content
        }
        
        copy.configurations.append(config)
        return copy
    }
}
