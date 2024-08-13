//
//  OpenBannedUserListView+ViewConverter.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

// MARK: - ViewConverter
extension OpenBannedUserListView {
    var viewConverter: OpenBannedUserListViewConverter {
        get { SBViewConverterSet.OpenBannedUserList }
        set {
            let config = { (_: SBUUserListViewController) in }
            configurations.append(config)
            SBViewConverterSet.OpenBannedUserList = newValue
        }
    }
    
    func setupViewConverterIfNeeded() {
        _ = self.viewConverter
    }
    
    mutating func applyViewConverterSet() {
        self.viewConverter = viewConverter
    }
}
