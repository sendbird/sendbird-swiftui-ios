//
//  SBUChannelStateBanner+SwiftUI.swift
//  SendbirdUIKit
//
//  Created by Celine Moon on 7/4/24.
//

import UIKit
import SendbirdChatSDK

extension SBUChannelStateBanner {
    typealias ViewConverter = GroupChannelViewConverter.List.ChannelStateBar
    var viewConverter: ViewConverter {
        SBViewConverterSet.GroupChannel.list.channelStateBar
    }
    
    @discardableResult
    func applyViewConverter(_ viewType: ViewConverter.ViewType) -> Bool {
        let tag = viewType.tag
        
        switch viewType {
        case .entireContent:
            if let viewConverter = self.viewConverter.entireContent,
               let hostingView = viewConverter(.init()) {

                self.viewWithTag(tag)?.removeFromSuperview()

                hostingView.tag = tag
                self.addSubview(hostingView)

                self.backgroundColor = .clear
                hostingView.sbu_constraint_fill(equalTo: self)
                
                return true
            }
        }
        return false
    }
}
