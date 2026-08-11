//
//  ViewItemProtocol.swift
//  SendbirdSwiftUI
//
//  Created by Tez Park on 6/27/24.
//

import SwiftUI

// typealias ViewItemProtocol = ViewItemType & ViewItemInitialize

// protocol ViewItemType {
protocol ViewItemProtocol {
    associatedtype ViewConverterType
    associatedtype ViewContent
    
    var viewConverter: ViewConverterType { get set}
    
    func createViewConverter<Content: View, Config: ViewConfigurations>(
        content: @escaping (Config) -> Content
    ) -> ViewConverter<Config>
}

// extension ViewItemType {
extension ViewItemProtocol {
    func createViewConverter<Content: View, Config: ViewConfigurations>(
        content: @escaping (Config) -> Content  // SwiftUI View
    ) -> ViewConverter<Config> {
        return ViewConverter { config in
            let hostingController = UIHostingController(rootView: content(config))
            // SBISSUE-21868: On iOS 26, a detached hosting view (its controller is never added to
            // the view controller hierarchy) starts receiving window-level safe-area insets and
            // includes them in its intrinsicContentSize. Cell heights are measured while cells sit
            // at/below the bottom screen edge during scrolling, so the inset (34pt home indicator,
            // or more when laid out off-screen) gets baked into cached row heights, producing
            // intermittent gaps/overlaps between cells. Hosted views are always embedded in
            // UIKit-managed containers that already handle safe-area avoidance, so opting the
            // hosted content out of all safe-area regions is safe and restores the iOS 18 behavior
            // (where these views never received safe-area insets).
            if #available(iOS 16.4, *) {
                hostingController.safeAreaRegions = []
            }
            let view = hostingController.view
            view?.backgroundColor = .clear
            return view
        }
    }
}
