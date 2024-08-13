//
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import Foundation
import SendbirdChatSDK

// MARK: - Typealias

/// A typealias for a closure that builds a `OpenParticipantListViewBuilder`.
public typealias OpenParticipantListViewBuilder = (
    _ channelURL: String
) -> OpenParticipantListView

// MARK: - Extension: ViewBuilder
public extension OpenParticipantListView { }
