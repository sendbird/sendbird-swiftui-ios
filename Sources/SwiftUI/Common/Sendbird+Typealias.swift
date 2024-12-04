//
//  Sendbird+Typealias.swift
//  SendbirdUIKit
//
//  Created by Tez Park on 10/21/24.
//

import Foundation
import SendbirdChatSDK

public typealias SendbirdConnectionStateChangeHandler = (_ isConnected: Bool) -> Void
public typealias SendbirdErrorHandler = (_ error: SBError?) -> Void
