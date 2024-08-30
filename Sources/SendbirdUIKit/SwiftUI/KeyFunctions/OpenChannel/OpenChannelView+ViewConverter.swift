//
//  OpenChannelView+ViewConverter.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

// MARK: - ViewConverter
extension OpenChannelView {
    var viewConverter: OpenChannelViewConverter {
        get { SBViewConverterSet.OpenChannel }
        set {
            let config = { (_: SBUOpenChannelViewController) in }
            configurations.append(config)
            SBViewConverterSet.OpenChannel = newValue
        }
    }
    
    func setupViewConverterIfNeeded() {
        _ = self.viewConverter
    }
    
    mutating func applyViewConverterSet() {
        self.viewConverter = viewConverter
    }
}
