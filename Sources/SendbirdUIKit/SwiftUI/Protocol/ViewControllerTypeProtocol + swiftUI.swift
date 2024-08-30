//
//  ViewControllerTypeProtocol + swiftUI.swift
//  SwiftUITestApp
//
//  Created by Kai Lee on 4/22/24.
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SwiftUI

// MARK: - ViewControllerType
/// A protocol that all `UIView`s conform to, enabling extensions that have a `Self` reference.
protocol ViewControllerType: UIViewController {}

// MARK: - ViewType + ViewTypeProtocol
extension UIViewController: ViewControllerType {}

// MARK: - ViewControllerTypeProtocol + swiftUI
extension ViewControllerType {
    /// Returns a SwiftUI `View` representing this `UIViewController`, constructed with the given `makeView`
    /// closure and sized with the given sizing configuration.
    ///
    /// To perform additional configuration of the `UIViewController` instance, call `configure` on the
    /// returned SwiftUI `View`:
    /// ```
    /// MyUIViewController.swiftUI(…)
    ///   .configure { context in
    ///     context.viewController.doSomething()
    ///   }
    /// ```
    static func swiftUI(makeView: @escaping () -> Self) -> SwiftUIViewController<Self> {
        SwiftUIViewController(makeContent: makeView)
  }
}
