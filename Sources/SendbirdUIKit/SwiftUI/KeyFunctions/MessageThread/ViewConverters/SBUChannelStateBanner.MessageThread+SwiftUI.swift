//
//  SBUChannelStateBanner.MessageThread+SwiftUI.swift
//  SendbirdUIKit
//
//  Created by Damon Park on 7/7/24.
//

import UIKit
import SendbirdChatSDK

extension SBUChannelStateBanner {
    typealias ViewConverterForMessageThread = MessageThreadViewConverter.List.ChannelStateBar
    var viewConverterForMessageThread: ViewConverterForMessageThread {
        SBViewConverterSet.MessageThread.list.channelStateBar
    }
    
    @discardableResult
    func applyViewConverterForMessageThread(_ viewType: ViewConverterForMessageThread.ViewType) -> Bool {
        let tag = viewType.tag
        
        switch viewType {
        case .entireContent:
            guard let viewConverter = self.viewConverterForMessageThread.entireContent,
                  let hostingView = viewConverter(.init()) else { return false }
            
            self.viewWithTag(tag)?.removeFromSuperview()
            
            hostingView.tag = tag
            self.addSubview(hostingView)
            
            self.backgroundColor = .clear
            hostingView.sbu_constraint_fill(equalTo: self)
            
            return true
        }
    }
}
