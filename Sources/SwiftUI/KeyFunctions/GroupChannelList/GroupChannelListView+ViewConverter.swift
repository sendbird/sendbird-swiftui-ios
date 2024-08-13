//
//  GroupChannelListView+ViewConverter.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

// MARK: - ViewConverter
extension GroupChannelListView {
    var viewConverter: GroupChannelListViewConverter {
        get { SBViewConverterSet.GroupChannelList }
        set {
            let config = { (_: SBUGroupChannelListViewController) in }
            configurations.append(config)
            SBViewConverterSet.GroupChannelList = newValue
        }
    }
    
    func setupViewConverterIfNeeded() {
        _ = self.viewConverter
    }
    
    mutating func applyViewConverterSet() {
        self.viewConverter = viewConverter
    }
}
