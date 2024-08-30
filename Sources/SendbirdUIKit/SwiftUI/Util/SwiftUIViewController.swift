//
//  SwiftUIViewController.swift
//  SwiftUITestApp
//
//  Created by Kai Lee on 4/19/24.
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import Foundation
import SwiftUI

/// A `UIViewControllerRepresentable` SwiftUI `View` that wraps its `Content`
struct SwiftUIViewController<Content: UIViewController> {
    typealias Configuration = (Content) -> Void
    
    /// Creates a SwiftUI representation of the content view with the provided `makeContent` closure
    /// to construct it whenever `makeUIViewController(…)` is invoked.
    init(makeContent: @escaping () -> Content) {
        self.makeContent = makeContent
    }
    
    /// A closure that's invoked to construct the represented content view.
    var makeContent: () -> Content
    var configuration: Configuration?
}

// MARK: - UIViewControllerRepresentable
extension SwiftUIViewController: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        if findNavigationController() {
            let newViewController: UIViewController = makeContent()
            return newViewController
        } else {
            let contentViewController = makeContent()
            let navigationController = UINavigationController(rootViewController: contentViewController)
            
            navigationController.delegate = context.coordinator
            context.coordinator.parent = self
            context.coordinator.navigationController = navigationController
            
            return navigationController
        }
    }
    
    func updateUIViewController(_ viewController: UIViewController, context: Context) {
        if let navigationController = viewController as? UINavigationController,
           let uiViewController = navigationController.viewControllers.first as? Content {
            configuration?(uiViewController)
        } else {
            context.coordinator.parentObserver = viewController.observe(\.parent, changeHandler: { viewController, _ in
                DispatchQueue.main.async {
                    let parentItem = viewController.parent?.navigationItem
                    let currentItem = viewController.navigationItem
                    parentItem?.titleView = currentItem.titleView
                    parentItem?.leftBarButtonItems = currentItem.leftBarButtonItems
                    parentItem?.rightBarButtonItems = currentItem.rightBarButtonItems
                }
            })
            
            if let viewController = viewController as? Content {
                configuration?(viewController)
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate {
        var parent: SwiftUIViewController
        var parentObserver: NSKeyValueObservation?
        var navigationController: UINavigationController?
        
        init(_ parent: SwiftUIViewController) {
            self.parent = parent
        }
    }
    
    // Function to find existing UINavigationController in the current scene
    private func findNavigationController() -> Bool {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            for window in windowScene.windows {
                if let navigationController = window.rootViewController as? UINavigationController {
                    return true
                } else if let rootViewController = window.rootViewController {
                    return findNavigationController(from: rootViewController)
                }
            }
        }
        return false
    }
    
    private func findNavigationController(from viewController: UIViewController) -> Bool {
        if let navigationController = viewController as? UINavigationController {
            for viewController in navigationController.viewControllers {
                if viewController is SBUBaseViewController {
                    return true
                } else {
                    if viewController.children.count > 0 {
                        return findNavigationController(from: viewController)
                    }
                }
            }
        }
        
        for child in viewController.children {
            return findNavigationController(from: child)
        }
        return false
    }
}

extension SwiftUIViewController {
    /// Returns a copy of this view updated to have the given closure applied to its represented view
    /// whenever it is updated via the `updateUIView(…)` method.
    func configure(_ configure: @escaping Configuration) -> Self {
        var copy = self
        copy.configuration = configure
        return copy
    }
}
