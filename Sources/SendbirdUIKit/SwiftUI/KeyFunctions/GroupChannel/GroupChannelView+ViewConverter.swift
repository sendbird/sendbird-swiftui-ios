//
//  GroupChannelView+ViewConverter.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

// MARK: - ViewConverter
extension GroupChannelView {
    var viewConverter: GroupChannelViewConverter {
        get { SBViewConverterSet.GroupChannel }
        set {
            let config = { (_: SBUGroupChannelViewController) in }
            configurations.append(config)
            SBViewConverterSet.GroupChannel = newValue
        }
    }
    
    func setupViewConverterIfNeeded() {
        _ = self.viewConverter
    }
    
    mutating func applyViewConverterSet() {
        self.viewConverter = viewConverter
    }
}
