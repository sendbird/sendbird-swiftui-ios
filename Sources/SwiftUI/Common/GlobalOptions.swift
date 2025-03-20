//
//  GlobalOptions.swift
//  SendbirdSwiftUI
//
//  Created by Celine Moon on 3/18/25.
//

import Foundation

/// Class that manages global settings for SendbirdSwiftUI.
/// - Since: 1.0.3
public class GlobalOptions {
    /// Decides whether to reset customized view adaptors whenever SendbirdSwiftUI View's `onDisappear` is called.
    /// Set this flag to `false` before a specific SendbirdSwiftUI View appears, if you want to prevent its customized views from resetting, even after its `onDisappear` is called.
    /// Set to `true` by default.
    /// - Since: 1.0.3
    public static var enableViewAdaptorAutoReset = true
}
