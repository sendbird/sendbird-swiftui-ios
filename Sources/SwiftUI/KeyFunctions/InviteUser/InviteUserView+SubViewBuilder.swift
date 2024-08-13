//
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import Foundation
import SendbirdChatSDK

// MARK: - Typealias
/// A typealias for a closure that builds a `InviteUserView`.
public typealias InviteUserViewBuilder = (
    _ channelURL: String
) -> InviteUserView

// MARK: - Extension: ViewBuilder
public extension InviteUserView {}
