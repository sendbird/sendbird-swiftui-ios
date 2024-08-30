//
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import Foundation
import SendbirdChatSDK

// MARK: - Typealias
/// A typealias for a closure that builds a `GroupMutedMemberListViewBuilder`.
public typealias GroupMutedMemberListViewBuilder = (
    _ channelURL: String
) -> GroupMutedMemberListView

// MARK: - Extension: ViewBuilder
public extension GroupMutedMemberListView { }
