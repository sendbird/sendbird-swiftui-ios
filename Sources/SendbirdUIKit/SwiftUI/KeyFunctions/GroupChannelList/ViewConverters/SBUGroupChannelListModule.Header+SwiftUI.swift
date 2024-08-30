//
//  GroupChannelListView+ViewConverter.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SwiftUI
import SendbirdChatSDK

extension SBUGroupChannelListModule.Header {
    typealias ViewConverter = GroupChannelListViewConverter.Header
    
    var viewConverter: ViewConverter {
        SBViewConverterSet.GroupChannelList.header
    }
}

extension SBUGroupChannelListModule.Header {
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
                self.leftBarButton?.tag = ViewConverter.ViewType.leftView.tag
                    
                return true
            } else {
                self.leftBarButton = self.defaultLeftButton
                return false
            }
        case .rightView:
            if let rightViewConverter = self.viewConverter.rightView.entireContent,
               let hostingView = rightViewConverter(.init(parentView: self)) {
                self.rightBarButton = SwiftUIBarButtonItem(
                    subview: hostingView,
                    target: self,
                    action: #selector(self.onTapRightBarButton)
                )
                self.rightBarButton?.tag = ViewConverter.ViewType.rightView.tag
                
                return true
            } else {
                self.rightBarButton = self.defaultRightBarButton
                return false
            }
        case .titleView:
            if let titleViewConverter = self.viewConverter.titleView.entireContent,
               let hostingView = titleViewConverter(.init(parentView: self)) {
                let titleView = SwiftUIContainerView(subview: hostingView)
                self.titleView = titleView
                self.titleView?.tag = ViewConverter.ViewType.titleView.tag
                
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
