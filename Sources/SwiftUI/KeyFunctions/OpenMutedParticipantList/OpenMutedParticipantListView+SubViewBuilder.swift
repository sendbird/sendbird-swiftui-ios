//
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import Foundation
import SendbirdChatSDK

// MARK: - Typealias
/// A typealias for a closure that builds a `OpenMutedParticipantListViewBuilder`.
public typealias OpenMutedParticipantListViewBuilder = (
    _ channelURL: String
) -> OpenMutedParticipantListView

// MARK: - Extension: ViewBuilder
public extension OpenMutedParticipantListView { }
