//
//  SBUOpenScrollBottomView+SwiftUI.swift
//  SendbirdSwiftUI
//
//  Created by Tez Park on 7/6/24.
//

import UIKit
import SendbirdChatSDK

extension SBUScrollBottomView {
    typealias ViewConverterForOpen = OpenChannelViewConverter.List.ScrollBottomView
    var viewConverterForOpen: ViewConverterForOpen {
        SBViewConverterSet.OpenChannel.list.scrollBottomView
    }
    
    @discardableResult
    func applyViewConverterForOpen(
        _ viewType: ViewConverterForOpen.ViewType,
        target: Any,
        action: Selector
    ) -> Bool {
        let tag = viewType.tag
        
        switch viewType {
        case .entireContent:
            if let viewConverter = self.viewConverterForOpen.entireContent,
               let hostingView = viewConverter(.init()) {
                // setupViews
                self.button.removeFromSuperview()
                self.viewWithTag(tag)?.removeFromSuperview()
                
                hostingView.tag = tag
                self.addSubview(hostingView)
                
                // Fit to right and bottom
                hostingView.sbu_constraint(equalTo: self, right: 0, bottom: 0)
                hostingView.sbu_constraint(
                    width: hostingView.intrinsicContentSize.width,
                    height: hostingView.intrinsicContentSize.height)
                
                // setupActions
                let tapGestureRecognizer = UITapGestureRecognizer(target: target, action: action)
                hostingView.addGestureRecognizer(tapGestureRecognizer)
                
                return true
            }
        }
        return false
    }
}
