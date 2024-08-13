//
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import Foundation
import SendbirdChatSDK

// MARK: - Typealias
/// A typealias for a closure that builds a `GroupBannedUserListViewBuilder`.
public typealias GroupBannedUserListViewBuilder = (
    _ channelURL: String
) -> GroupBannedUserListView

// MARK: - Extension: ViewBuilder
public extension GroupBannedUserListView { }
