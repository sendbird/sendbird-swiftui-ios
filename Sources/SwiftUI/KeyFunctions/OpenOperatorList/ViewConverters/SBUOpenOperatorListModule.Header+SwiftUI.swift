//
//  SBUOpenOperatorListModule.Header+SwiftUI.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SwiftUI
import SendbirdChatSDK

extension SBUUserListModule.Header {
    typealias ViewConverterForOpenOperators = OpenOperatorListViewConverter.Header
    
    var viewConverterForOpenOperators: ViewConverterForOpenOperators {
        SBViewConverterSet.OpenOperatorList.header
    }
}

extension SBUUserListModule.Header {
    @discardableResult
    func applyViewConverterForOpenOperators(_ viewType: ViewConverterForOpenOperators.ViewType) -> Bool {
        switch viewType {
        case .leftView:
            if let leftViewConverter = self.viewConverterForOpenOperators.leftView.entireContent,
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
            if let rightViewConverter = self.viewConverterForOpenOperators.rightView.entireContent,
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
            if let titleViewConverter = self.viewConverterForOpenOperators.titleView.entireContent,
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


