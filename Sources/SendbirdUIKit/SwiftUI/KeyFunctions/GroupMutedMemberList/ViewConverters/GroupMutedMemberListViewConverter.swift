//
//  GroupMutedMemberListView+ViewConverter.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

/// A converter that updates the views of a `SBUUserListViewController`.
public struct GroupMutedMemberListViewConverter {
    // MARK: TypeAlias
    typealias UpdatableVC = SBUUserListViewController
    
    // MARK: Converter
    var header = Header()
    var list = List()
    // TODO: header, list 외에 필요한 converter 가 있다면 계속 구현
    
    // MARK: View updater
    func applyViewUpdates(to viewController: UpdatableVC, includeSubDepth: Bool = true) {
        self.header.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
        self.list.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
        // TODO: header, list 외에 구현되는게 있다면 applyViewUpdates 구현
    }
}
