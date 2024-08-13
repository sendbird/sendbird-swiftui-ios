//
//  OpenChannelListView+ViewConverter.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

// MARK: - ViewConverter
extension OpenChannelListView {
    var viewConverter: OpenChannelListViewConverter {
        get { SBViewConverterSet.OpenChannelList }
        set {
            let config = { (_: SBUOpenChannelListViewController) in }
            configurations.append(config)
            SBViewConverterSet.OpenChannelList = newValue
        }
    }
    
    func setupViewConverterIfNeeded() {
        _ = self.viewConverter
    }
    
    mutating func applyViewConverterSet() {
        self.viewConverter = viewConverter
    }
}
