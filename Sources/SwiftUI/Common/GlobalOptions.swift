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
    
    /// Setting this flag to `true` removes the default liquid glass effect from custom SendbirdSwiftUI navigation bar buttons for iOS 26 or above.
    /// Setting this flag to `false` shows the default liquid glass effect from custom SendbirdSwiftUI navigation bar buttons for iOS 26 or above.
    /// The default is set to `false`.
    ///
    /// ```
    /// GlobalOptions.hidesSharedBackgroundForUIBarButtonItem = false // shows liquid glass effect on custom SendbirdSwiftUI navigation bar buttons.
    /// GlobalOptions.hidesSharedBackgroundForUIBarButtonItem = true // removes liquid glass effect from custom SendbirdSwiftUI navigation bar buttons.
    /// ```
    ///
    /// - Since: 1.1.2
    @available(iOS 26, *)
    public static var hidesSharedBackgroundForCustomNavBarButton: Bool = false // swiftlint:disable:this identifier_name
}
