//
//  MessageThreadView+ViewConverter.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

// MARK: - ViewConverter
extension MessageThreadView {
    var viewConverter: MessageThreadViewConverter {
        get { SBViewConverterSet.MessageThread }
        set {
            let config = { (_: SBUMessageThreadViewController) in }
            configurations.append(config)
            SBViewConverterSet.MessageThread = newValue
        }
    }
    
    func setupViewConverterIfNeeded() {
        _ = self.viewConverter
    }
    
    mutating func applyViewConverterSet() {
        self.viewConverter = viewConverter
    }
}
