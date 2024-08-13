//
//  GroupChannelListView+ViewConverter.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

/// A converter that updates the views of a `SBUGroupChannelListViewController`.
public struct GroupChannelListViewConverter {
    // MARK: TypeAlias
    typealias UpdatableVC = SBUGroupChannelListViewController
    
    // MARK: Converter
    var header = Header()
    var list = List()
    
    // MARK: View updater
    func applyViewUpdates(to viewController: UpdatableVC, includeSubDepth: Bool = true) {
        self.header.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
        self.list.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
    }
}
