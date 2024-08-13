//
//  SBUScrollBottomView+SwiftUI.swift
//  SendbirdSwiftUI
//
//  Created by Celine Moon on 7/4/24.
//

import UIKit
import SendbirdChatSDK

extension SBUScrollBottomView {
    typealias ViewConverter = GroupChannelViewConverter.List.ScrollBottomView
    var viewConverter: ViewConverter {
        SBViewConverterSet.GroupChannel.list.scrollBottomView
    }
    
    @discardableResult
    func applyViewConverter(
        _ viewType: ViewConverter.ViewType,
        target: Any,
        action: Selector
    ) -> Bool {
        let tag = viewType.tag
        
        switch viewType {
        case .entireContent:
            if let viewConverter = self.viewConverter.entireContent,
               let hostingView = viewConverter(.init()) {
                // setupViews
                self.button.removeFromSuperview()
                self.viewWithTag(tag)?.removeFromSuperview()

                hostingView.tag = tag
                self.addSubview(hostingView)
                
                // setupLayouts
                hostingView.sbu_constraint_fill(equalTo: self)
                
                // setupActions
                let tapGestureRecognizer = UITapGestureRecognizer(target: target, action: action)
                hostingView.addGestureRecognizer(tapGestureRecognizer)
                
                return true
            }
        }
        return false 
    }
}
