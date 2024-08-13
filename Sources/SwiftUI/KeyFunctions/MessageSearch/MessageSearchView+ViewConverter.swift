//
//  MessageSearchView+ViewConverter.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

// MARK: - ViewConverter
extension MessageSearchView {
    var viewConverter: MessageSearchViewConverter {
        get { SBViewConverterSet.MessageSearch }
        set {
            let config = { (_: SBUMessageSearchViewController) in }
            configurations.append(config)
            SBViewConverterSet.MessageSearch = newValue
        }
    }
    
    func setupViewConverterIfNeeded() {
        _ = self.viewConverter
    }
    
    mutating func applyViewConverterSet() {
        self.viewConverter = viewConverter
    }
}
