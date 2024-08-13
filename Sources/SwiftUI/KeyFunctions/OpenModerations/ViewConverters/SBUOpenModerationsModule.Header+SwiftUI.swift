//
//  OpenModerationsView+ViewConverter.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SwiftUI
import SendbirdChatSDK

extension SBUModerationsModule.Header {
    typealias ViewConverterForOpen = OpenModerationsViewConverter.Header
    
    var viewConverterForOpen: ViewConverterForOpen {
        SBViewConverterSet.OpenModerations.header
    }
}

extension SBUModerationsModule.Header {
    @discardableResult
    func applyViewConverterForOpen(_ viewType: ViewConverterForOpen.ViewType) -> Bool {
        switch viewType {
        case .leftView:
            if let leftViewConverter = self.viewConverterForOpen.leftView.entireContent,
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
            if let rightViewConverter = self.viewConverterForOpen.rightView.entireContent,
               let hostingView = rightViewConverter(.init(parentView: self)) {
                self.rightBarButton = SwiftUIBarButtonItem(subview: hostingView) // no action by default
                
                return true
            } else {
                self.rightBarButton = nil
                return false
            }
        case .titleView:
            if let titleViewConverter = self.viewConverterForOpen.titleView.entireContent,
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
    
    func updateEnableStateForOpen(viewType: ViewConverterForOpen.ViewType, state: Bool) {
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
    
    func updateHiddenStateForOpen(viewType: ViewConverterForOpen.ViewType, state: Bool) {
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
