//
//  Closure.swift
//  SendbirdUIKit
//
//  Created by Kai Lee on 5/13/24.
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import Foundation

/// A generic structure that encapsulates a closure and its call behavior.
/// - Parameters:
///   - ParameterType: The type of the parameter that the closure accepts.
///   - ReturnType: The type of the value that the closure returns.
struct Closure<ParameterType, ReturnType> {
    var closure: (ParameterType) -> ReturnType
    var callBehavior: CallBehavior
    
    func callAsFunction(_ param: ParameterType) -> ReturnType {
        closure(param)
    }
    
    init(behavior: CallBehavior, closure: @escaping (ParameterType) -> ReturnType) {
        self.callBehavior = behavior
        self.closure = closure
    }
}

extension Closure {
    /// Defines the behavior of the closure call.
    enum CallBehavior {
        /// The closure is called before the original execution.
        case pre
        /// The closure is called after the original execution.
        case post
        /// The closure overrides the original execution.
        case override
    }
}

// MARK: - Internal util
struct ClosureExecutor {
    /// Executes the given closure with the specified behavior.
    /// - Parameters:
    ///   - argument: The argument to pass to the closure and the original function.
    ///   - closure: The closure to execute, which may be nil.
    ///   - original: The original function to execute.
    /// - Returns: The result of the original function or the closure, depending on the call behavior.
    static func executeWithBehavior<P, R>(
        argument: P,
        closure: Closure<P, R>?,
        original: (P) -> R
    ) -> R {
        guard let closure else {
            return original(argument)
        }
        
        switch closure.callBehavior {
        case .pre:
            _ = closure(argument)
            return original(argument)
        case .post:
            let result = original(argument)
            _ = closure(argument)
            return result
        case .override:
            return closure(argument)
        }
    }
}
