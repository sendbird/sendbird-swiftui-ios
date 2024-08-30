//
//  OpenMutedParticipantListView+ViewConverter.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

// MARK: - ViewConverter
extension OpenMutedParticipantListView {
    var viewConverter: OpenMutedParticipantListViewConverter {
        get { SBViewConverterSet.OpenMutedParticipantList }
        set {
            let config = { (_: SBUUserListViewController) in }
            configurations.append(config)
            SBViewConverterSet.OpenMutedParticipantList = newValue
        }
    }
    
    func setupViewConverterIfNeeded() {
        _ = self.viewConverter
    }
    
    mutating func applyViewConverterSet() {
        self.viewConverter = viewConverter
    }
}
