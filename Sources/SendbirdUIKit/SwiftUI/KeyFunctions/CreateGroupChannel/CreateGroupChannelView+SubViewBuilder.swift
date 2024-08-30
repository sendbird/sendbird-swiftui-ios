//
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import Foundation
import SendbirdChatSDK

// MARK: - Typealias
/// A typealias for a closure that builds a `CreateGroupChannelView`.
public typealias CreateGroupChannelViewBuilder = (
    _ users: [SBUUser]?,
    _ type: ChannelCreationType
) -> CreateGroupChannelView

// MARK: - Extension: ViewBuilder
public extension CreateGroupChannelView {}
