//
//  MethodOverridable.swift
//  SendbirdUIKit
//
//  Created by Kai Lee on 5/22/24.
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import Foundation

/// A protocol that defines a type that can override methods
protocol Overridable: MethodOverridable, ProtocolOverridable, PropertyCustmizable {}

protocol MethodOverridable {
    associatedtype MethodHandlerSetType
    var methodHandlerSet: MethodHandlerSetType { get set }
}

protocol ProtocolOverridable {
    associatedtype ProtocolHandlerSetType
    var protocolHandlerSet: ProtocolHandlerSetType { get set }
}

protocol PropertyCustmizable {
    associatedtype UIKitType
    associatedtype ReturnType
    
    var propertyHandler: Closure<UIKitType, ReturnType>? { get set }
}
