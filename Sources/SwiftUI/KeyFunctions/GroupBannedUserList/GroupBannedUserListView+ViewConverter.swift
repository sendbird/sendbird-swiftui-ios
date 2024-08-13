//
//  GroupBannedUserListView+ViewConverter.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

// MARK: - ViewConverter
extension GroupBannedUserListView {
    var viewConverter: GroupBannedUserListViewConverter {
        get { SBViewConverterSet.GroupBannedUserList }
        set {
            let config = { (_: SBUUserListViewController) in }
            configurations.append(config)
            SBViewConverterSet.GroupBannedUserList = newValue
        }
    }
    
    func setupViewConverterIfNeeded() {
        _ = self.viewConverter
    }
    
    mutating func applyViewConverterSet() {
        self.viewConverter = viewConverter
    }
}
