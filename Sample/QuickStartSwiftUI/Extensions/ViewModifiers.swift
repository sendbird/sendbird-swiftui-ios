//
//  ViewModifiers.swift
//  QuickStartSwiftUI
//
//  Created by Celine Moon on 7/15/24.
//

import SwiftUI

struct RoundedBackgroundModifier: ViewModifier {
    var color: Color
    var verticalPadding: CGFloat
    
    func body(content: Content) -> some View {
        content
            .padding(.vertical, verticalPadding)
            .padding(.horizontal, 16)
            .background(RoundedRectangle(cornerRadius: 16).fill(color))
    }
}

extension View {
    func roundedBackground(color: Color, verticalPadding: CGFloat = 16.0) -> some View {
        self.modifier(RoundedBackgroundModifier(color: color, verticalPadding: verticalPadding))
    }
}
