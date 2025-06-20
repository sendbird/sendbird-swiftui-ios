//
//  SwiftUIView.swift
//  SendbirdSwiftUI
//
//  Created by Celine Moon on 5/19/25.
//

import Foundation
import SwiftUI

// MARK: - SendbirdView

/// SwiftUI View protocol for UIView wrappers.
/// - Since: 1.1.0
protocol SendbirdView: View {
    /// UIView type that is wrapped as View.
    associatedtype SBUViewType: UIView
    
    /// Called when initializing UIView.
    func createUIView() -> SBUViewType
}

// MARK: - UIViewType

/// - Since: 1.1.0
protocol UIViewType: UIView { }
extension UIViewType {
    static func swiftUI(makeContent: @escaping () -> Self) -> SwiftUIView<Self> {
        SwiftUIView(makeContent: makeContent)
    }
}

extension UIView: UIViewType {}

// MARK: - SwiftUIView

/// - Since: 1.1.0
struct SwiftUIView<Content: UIView> {
    
    /// Creates a SwiftUI representation of the content view with the provided `makeContent` closure
    /// to construct it whenever `makeUIViewController(…)` is invoked.
    init(makeContent: @escaping () -> Content) {
        self.makeContent = makeContent
    }
    
    /// A closure that's invoked to construct the represented content view.
    var makeContent: () -> Content
}

extension SwiftUIView: UIViewRepresentable {
    func makeUIView(context: Context) -> Content {
        return makeContent()
    }
    
    func updateUIView(_ uiView: Content, context: Context) {
        // SwiftUI View update cycle.
        // UIView update logic goes here.
    }
}
