//
//  CreateGroupChannelView+ViewConverter.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

// MARK: - ViewConverter
extension CreateGroupChannelView {
    var viewConverter: CreateGroupChannelViewConverter {
        get { SBViewConverterSet.CreateGroupChannel }
        set {
            let config = { (_: SBUCreateChannelViewController) in }
            configurations.append(config)
            SBViewConverterSet.CreateGroupChannel = newValue
        }
    }
    
    func setupViewConverterIfNeeded() {
        _ = self.viewConverter
    }
    
    mutating func applyViewConverterSet() {
        self.viewConverter = viewConverter
    }
}
