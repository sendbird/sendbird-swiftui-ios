//
//  SBUGroupMutedMemberListModule.HEader+SwiftUI.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SwiftUI
import SendbirdChatSDK

extension SBUUserListModule.Header {
    typealias ViewConverterForMutedMember = GroupMutedMemberListViewConverter.Header
    
    var viewConverterForMutedMember: ViewConverterForMutedMember {
        SBViewConverterSet.GroupMutedMemberList.header
    }
}

extension SBUUserListModule.Header {
    @discardableResult
    func applyViewConverterForMutedMember(_ viewType: ViewConverterForMutedMember.ViewType) -> Bool {
        switch viewType {
        case .leftView:
            if let leftViewConverter = self.viewConverterForMutedMember.leftView.entireContent,
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
            if let rightViewConverter = self.viewConverterForMutedMember.rightView.entireContent,
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
            if let titleViewConverter = self.viewConverterForMutedMember.titleView.entireContent,
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


