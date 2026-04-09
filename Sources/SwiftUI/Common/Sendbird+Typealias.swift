//
//  Sendbird+Typealias.swift
//  SendbirdUIKit
//
//  Created by Tez Park on 10/21/24.
//

import Foundation
import SendbirdChatSDK

/// A closure type invoked when the Sendbird connection state changes.
public typealias SendbirdConnectionStateChangeHandler = (_ isConnected: Bool) -> Void
/// A closure type invoked when a Sendbird operation completes with an optional error.
public typealias SendbirdErrorHandler = (_ error: SBError?) -> Void
