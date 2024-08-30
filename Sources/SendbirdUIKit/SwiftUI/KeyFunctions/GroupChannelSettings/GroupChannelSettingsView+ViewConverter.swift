//
//  GroupChannelSettingsView+ViewConverter.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

// MARK: - ViewConverter
extension GroupChannelSettingsView {
    var viewConverter: GroupChannelSettingsViewConverter {
        get { SBViewConverterSet.GroupChannelSettings }
        set {
            let config = { (_: SBUGroupChannelSettingsViewController) in }
            configurations.append(config)
            SBViewConverterSet.GroupChannelSettings = newValue
        }
    }
    
    func setupViewConverterIfNeeded() {
        _ = self.viewConverter
    }
    
    mutating func applyViewConverterSet() {
        self.viewConverter = viewConverter
    }
}
