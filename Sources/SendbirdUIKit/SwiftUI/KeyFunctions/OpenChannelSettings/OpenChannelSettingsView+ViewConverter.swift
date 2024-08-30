//
//  OpenChannelSettingsView+ViewConverter.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

// MARK: - ViewConverter
extension OpenChannelSettingsView {
    var viewConverter: OpenChannelSettingsViewConverter {
        get { SBViewConverterSet.OpenChannelSettings }
        set {
            let config = { (_: SBUOpenChannelSettingsViewController) in }
            configurations.append(config)
            SBViewConverterSet.OpenChannelSettings = newValue
        }
    }
    
    func setupViewConverterIfNeeded() {
        _ = self.viewConverter
    }
    
    mutating func applyViewConverterSet() {
        self.viewConverter = viewConverter
    }
}
