//
//  StateImpactManager.swift
//  SendbirdUIKit
//
//  Created by Tez Park on 11/14/24.
//

import Foundation

struct StateImpactHandler {
    /// This function helps avoid the `publishing changes from within view updates is not allowed, this will cause undefined behavior` error
    static func safeExecute(_ work: @escaping () -> Void) {
        DispatchQueue.main.async {
            work()
        }
    }
}
