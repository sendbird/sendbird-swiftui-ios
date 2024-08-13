//
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import Foundation
import SendbirdChatSDK

// MARK: - Typealias

/// A typealias for a closure that builds a `MessageThreadViewBuilder`.
public typealias MessageThreadViewBuilder = (
    _ channelURL: String,
    _ parentMessageId: Int64
) -> MessageThreadView

// MARK: - Extension: ViewBuilder
public extension MessageThreadView {}
