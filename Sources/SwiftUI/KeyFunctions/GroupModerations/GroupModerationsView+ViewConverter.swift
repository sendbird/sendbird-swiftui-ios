//
//  GroupModerationsView+ViewConverter.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

// MARK: - ViewConverter
extension GroupModerationsView {
    var viewConverter: GroupModerationsViewConverter {
        get { SBViewConverterSet.GroupModerations }
        set {
            let config = { (_: SBUModerationsViewController) in }
            configurations.append(config)
            SBViewConverterSet.GroupModerations = newValue
        }
    }
    
    func setupViewConverterIfNeeded() {
        _ = self.viewConverter
    }
    
    mutating func applyViewConverterSet() {
        self.viewConverter = viewConverter
    }
}
