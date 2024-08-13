//
//  InviteUserView+ViewConverter.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

// MARK: - ViewConverter
extension InviteUserView {
    var viewConverter: InviteUserViewConverter {
        get { SBViewConverterSet.InviteUser }
        set {
            let config = { (_: SBUInviteUserViewController) in }
            configurations.append(config)
            SBViewConverterSet.InviteUser = newValue
        }
    }
    
    func setupViewConverterIfNeeded() {
        _ = self.viewConverter
    }
    
    mutating func applyViewConverterSet() {
        self.viewConverter = viewConverter
    }
}
