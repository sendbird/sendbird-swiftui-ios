//
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import Foundation
import SendbirdChatSDK

// MARK: - Typealias
/// A typealias for a closure that builds a `OpenBannedUserListViewBuilder`.
public typealias OpenBannedUserListViewBuilder = (
    _ channelURL: String
) -> OpenBannedUserListView

// MARK: - Extension: ViewBuilder
public extension OpenBannedUserListView { }
