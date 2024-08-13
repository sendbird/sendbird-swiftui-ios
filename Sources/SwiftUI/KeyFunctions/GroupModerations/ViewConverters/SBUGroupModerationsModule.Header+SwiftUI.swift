//
//  GroupModerationsView+ViewConverter.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SwiftUI
import SendbirdChatSDK

extension SBUModerationsModule.Header {
    typealias ViewConverter = GroupModerationsViewConverter.Header
    
    var viewConverter: ViewConverter {
        SBViewConverterSet.GroupModerations.header
    }
}

extension SBUModerationsModule.Header {
    @discardableResult
    func applyViewConverter(_ viewType: ViewConverter.ViewType) -> Bool {
        switch viewType {
        case .leftView:
            if let leftViewConverter = self.viewConverter.leftView.entireContent,
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
            if let rightViewConverter = self.viewConverter.rightView.entireContent,
               let hostingView = rightViewConverter(.init(parentView: self)) {
                self.rightBarButton = SwiftUIBarButtonItem(subview: hostingView) // No action by default.
                
                return true
            } else {
                self.rightBarButton = nil
                return false
            }
        case .titleView:
            if let titleViewConverter = self.viewConverter.titleView.entireContent,
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
    
    func updateEnableState(viewType: ViewConverter.ViewType, state: Bool) {
        switch viewType {
        case .leftView:
            if let leftBarButton = self.leftBarButton,
               leftBarButton.tag == viewType.tag {
                leftBarButton.isEnabled = !state
            }
        case .rightView:
            if let rightBarButton = self.rightBarButton,
               rightBarButton.tag == viewType.tag {
                rightBarButton.isEnabled = state
            }
        case .titleView:
            break
        }
    }
    
    func updateHiddenState(viewType: ViewConverter.ViewType, state: Bool) {
        switch viewType {
        case .leftView:
            if let leftBarButton = self.leftBarButton,
               leftBarButton.tag == viewType.tag {
                if #available(iOS 16.0, *) {
                    leftBarButton.isHidden = state
                } else {
                    break
                }
            }
        case .rightView:
            if let rightBarButton = self.rightBarButton,
               rightBarButton.tag == viewType.tag {
                if #available(iOS 16.0, *) {
                    rightBarButton.isHidden = state
                } else {
                    break
                }
            }
        case .titleView:
            if let titleView = self.titleView,
               titleView.tag == viewType.tag {
                titleView.isHidden = state
            }
        }
    }
}


