//
//  Color+Sendbird.swift
//  SendbirdSwiftUI
//
//  Created by Tez Park on 7/9/24.
//

import SwiftUI
import UIKit

extension Color {
    /// Color -> UIColor
    public func asUIColor() -> UIColor {
        UIColor(self)
    }
}


extension UIColor {
    /// UIColor -> Color
    public func asColor() -> Color {
        Color(uiColor: self)
    }
}
