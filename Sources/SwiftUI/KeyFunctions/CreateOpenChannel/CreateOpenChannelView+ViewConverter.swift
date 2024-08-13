//
//  CreateOpenChannelView+ViewConverter.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

// MARK: - ViewConverter
extension CreateOpenChannelView {
    var viewConverter: CreateOpenChannelViewConverter {
        get { SBViewConverterSet.CreateOpenChannel }
        set {
            let config = { (_: SBUCreateOpenChannelViewController) in }
            configurations.append(config)
            SBViewConverterSet.CreateOpenChannel = newValue
        }
    }
    
    func setupViewConverterIfNeeded() {
        _ = self.viewConverter
    }
    
    mutating func applyViewConverterSet() {
        self.viewConverter = viewConverter
    }
}
