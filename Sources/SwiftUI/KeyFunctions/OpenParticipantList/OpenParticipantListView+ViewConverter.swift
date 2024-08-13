//
//  OpenParticipantListView+ViewConverter.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

// MARK: - ViewConverter
extension OpenParticipantListView {
    var viewConverter: OpenParticipantListViewConverter {
        get { SBViewConverterSet.OpenParticipantList }
        set {
            let config = { (_: SBUUserListViewController) in }
            configurations.append(config)
            SBViewConverterSet.OpenParticipantList = newValue
        }
    }
    
    func setupViewConverterIfNeeded() {
        _ = self.viewConverter
    }
    
    mutating func applyViewConverterSet() {
        self.viewConverter = viewConverter
    }
}
