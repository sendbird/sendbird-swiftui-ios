//
//  OpenModerationsView+ViewConverter.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

// MARK: - ViewConverter
extension OpenModerationsView {
    var viewConverter: OpenModerationsViewConverter {
        get { SBViewConverterSet.OpenModerations }
        set {
            let config = { (_: SBUModerationsViewController) in }
            configurations.append(config)
            SBViewConverterSet.OpenModerations = newValue
        }
    }
    
    func setupViewConverterIfNeeded() {
        _ = self.viewConverter
    }
    
    mutating func applyViewConverterSet() {
        self.viewConverter = viewConverter
    }
}
