//
//  GroupChannelPushSettingsView+ViewConverter.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

// MARK: - ViewConverter
extension GroupChannelPushSettingsView {
    var viewConverter: GroupChannelPushSettingsViewConverter {
        get { SBViewConverterSet.GroupChannelPushSettings }
        set {
            let config = { (_: SBUGroupChannelPushSettingsViewController) in }
            configurations.append(config)
            SBViewConverterSet.GroupChannelPushSettings = newValue
        }
    }
    
    func setupViewConverterIfNeeded() {
        _ = self.viewConverter
    }
    
    mutating func applyViewConverterSet() {
        self.viewConverter = viewConverter
    }
}
