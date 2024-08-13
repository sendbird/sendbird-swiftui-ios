//
//  SBUOpenMutedParticipantListModule.Header+SwiftUI.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SwiftUI
import SendbirdChatSDK

extension SBUUserListModule.Header {
    typealias ViewConverterForOpenMutedParticipant = OpenMutedParticipantListViewConverter.Header
    
    var viewConverterForOpenMutedParticipant: ViewConverterForOpenMutedParticipant {
        SBViewConverterSet.OpenMutedParticipantList.header
    }
}

extension SBUUserListModule.Header {
    @discardableResult
    func applyViewConverterForOpenMutedParticipant(_ viewType: ViewConverterForOpenMutedParticipant.ViewType) -> Bool {
        switch viewType {
        case .leftView:
            if let leftViewConverter = self.viewConverterForOpenMutedParticipant.leftView.entireContent,
               let hostingView = leftViewConverter(.init(parentView: self)) {
                self.leftBarButton = SwiftUIBarButtonItem(
                    subview: hostingView,
                    target: self,
                    action: #selector(self.onTapLeftBarButton)
                )
                
                return true
            } else {
                self.leftBarButton = self.defaultLeftBarButton
                return false
            }
        case .rightView:
            if let rightViewConverter = self.viewConverterForOpenMutedParticipant.rightView.entireContent,
               let hostingView = rightViewConverter(.init(parentView: self)) {
                self.rightBarButton = SwiftUIBarButtonItem(
                    subview: hostingView,
                    target: self,
                    action: #selector(self.onTapRightBarButton)
                )
                
                return true
            } else {
                self.rightBarButton = self.defaultRightBarButton
                return false
            }
        case .titleView:
            if let titleViewConverter = self.viewConverterForOpenMutedParticipant.titleView.entireContent,
               let hostingView = titleViewConverter(.init(parentView: self)) {
                let titleView = SwiftUIContainerView(subview: hostingView)
                self.titleView = titleView
                
                return true
            } else {
                self.titleView = self.defaultTitleView
                return false
            }
        }
    }
}


