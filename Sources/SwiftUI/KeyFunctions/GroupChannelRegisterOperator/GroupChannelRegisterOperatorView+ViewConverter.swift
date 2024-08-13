//
//  GroupChannelRegisterOperatorView+ViewConverter.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

// MARK: - ViewConverter
extension GroupChannelRegisterOperatorView {
    var viewConverter: GroupChannelRegisterOperatorViewConverter {
        get { SBViewConverterSet.GroupChannelRegisterOperator }
        set {
            let config = { (_: SBURegisterOperatorViewController) in }
            configurations.append(config)
            SBViewConverterSet.GroupChannelRegisterOperator = newValue
        }
    }
    
    func setupViewConverterIfNeeded() {
        _ = self.viewConverter
    }
    
    mutating func applyViewConverterSet() {
        self.viewConverter = viewConverter
    }
}
