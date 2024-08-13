//
//  MessageThreadView+ViewConverter.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SwiftUI
import SendbirdChatSDK

extension SBUMessageThreadModule.List {
    typealias ViewConverter = MessageThreadViewConverter.List
    var viewConverter: ViewConverter { SBViewConverterSet.MessageThread.list }
    
    typealias ViewConverterForParentInfo = MessageThreadViewConverter.ParentInfo
    var viewConverterForParentInfo: ViewConverterForParentInfo { SBViewConverterSet.MessageThread.parentInfo }
}

extension SBUMessageThreadModule.List {
    func applyViewConverter(_ viewType: ViewConverter.ViewType) -> Bool {
        guard let channel = self.channel else { return false }
        guard let parentMessage = self.parentMessage else { return false }
        
        let tag = viewType.tag
        
        switch viewType {
        case .entireContent:
            let config = ViewConverter.TableView.ViewConfig(
                channel: channel,
                parentMessage: parentMessage,
                messages: self.fullMessageList
            )
            guard let hostingView = self.viewConverter.tableView.entireContent?(config) else { return false }
                
            // remove UITableView
            self.tableView.removeFromSuperview()
            self.channelStateBanner?.removeFromSuperview()
            self.viewWithTag(tag)?.removeFromSuperview()
            
            self.voicePlayer = SBUVoicePlayer(delegate: self)
            
            // add hostingView as subview of List
            hostingView.tag = tag
            self.addSubview(hostingView)
            
            /* Layouts */
            // NOTES: hostingView.heightAnchor 지정 안해두면 SwiftUI List height가 안 잡힘.
            hostingView
                .sbu_constraint_fill(equalTo: self)
                .sbu_constraint(height: self.frame.height)
            return true
        }
    }
}
