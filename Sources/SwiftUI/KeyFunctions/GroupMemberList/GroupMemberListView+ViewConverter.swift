//
//  GroupMemberListView+ViewConverter.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

// MARK: - ViewConverter
extension GroupMemberListView {
    var viewConverter: GroupMemberListViewConverter {
        get { SBViewConverterSet.GroupMemberList }
        set {
            let config = { (_: SBUUserListViewController) in }
            configurations.append(config)
            SBViewConverterSet.GroupMemberList = newValue
        }
    }
    
    func setupViewConverterIfNeeded() {
        _ = self.viewConverter
    }
    
    mutating func applyViewConverterSet() {
        self.viewConverter = viewConverter
    }
}
