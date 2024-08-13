//
//  GroupChannelView+ViewConverter.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SwiftUI
import SendbirdChatSDK

extension SBUGroupChannelModule.List {
    typealias ViewConverter = GroupChannelViewConverter.List
    
    var viewConverter: ViewConverter {
        SBViewConverterSet.GroupChannel.list
    }
}

extension SBUGroupChannelModule.List {
    @discardableResult
    func applyViewConverter(_ viewType: ViewConverter.TableView.ViewType) -> Bool {
        guard let channel = self.channel else { return false }

        let tag = viewType.tag
        
        switch viewType {
        case .entireContent:
            if let tableViewConverter = self.viewConverter.tableView.entireContent,
               let hostingView = tableViewConverter(.init(
                channel: channel,
                messages: self.fullMessageList
               )) {
                // remove UITableView
                self.tableView.removeFromSuperview()
                // TODO: SwiftUI - channelStateBanner 는 List 가 아닌 Common 같은 다른 구조로 빼서 List 전체 교체와 따로 동작되도록 하자
                self.channelStateBanner?.removeFromSuperview()
                self.viewWithTag(tag)?.removeFromSuperview()
                
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
            return false
        }
    }
}
