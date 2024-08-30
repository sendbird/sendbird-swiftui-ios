//
//  OpenChannelRegisterOperatorView+ViewConverter.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

// MARK: - ViewConverter
extension OpenChannelRegisterOperatorView {
    var viewConverter: OpenChannelRegisterOperatorViewConverter {
        get { SBViewConverterSet.OpenChannelRegisterOperator }
        set {
            let config = { (_: SBURegisterOperatorViewController) in }
            configurations.append(config)
            SBViewConverterSet.OpenChannelRegisterOperator = newValue
        }
    }
    
    func setupViewConverterIfNeeded() {
        _ = self.viewConverter
    }
    
    mutating func applyViewConverterSet() {
        self.viewConverter = viewConverter
    }
}
