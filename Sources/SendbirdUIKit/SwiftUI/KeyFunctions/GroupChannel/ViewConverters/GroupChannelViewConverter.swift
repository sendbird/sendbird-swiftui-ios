//
//  GroupChannelView+ViewConverter.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

/// A converter that updates the views of a `SBUGroupChannelViewController`.
public struct GroupChannelViewConverter {
    // MARK: TypeAlias
    typealias UpdatableVC = SBUGroupChannelViewController
    
    // MARK: Converter
    var header = Header()
    var list = List()
    var input = Input()
    
    // MARK: View updater
    func applyViewUpdates(to viewController: UpdatableVC, includeSubDepth: Bool = true) {
        self.header.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
        self.list.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
        self.input.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
    }
}
