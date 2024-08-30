//
//  GroupChannelListView+ViewConverter.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SwiftUI
import SendbirdChatSDK

extension SBUGroupChannelListModule.List {
    typealias ViewConverter = GroupChannelListViewConverter.List
    
    var viewConverter: ViewConverter {
        SBViewConverterSet.GroupChannelList.list
    }
}

extension SBUGroupChannelListModule.List {
    func applyViewConverter(_ viewType: ViewConverter.TableView.ViewType) -> Bool {
        let tag = viewType.tag
        
        switch viewType {
        case .entireContent:
            if let tableViewConverter = self.viewConverter.tableView.entireContent,
               let groupChannels = self.baseChannelList as? [GroupChannel],
               let hostingView = tableViewConverter(.init(channels: groupChannels)) {
                
                // remove UITableView
                self.tableView.removeFromSuperview()
                self.viewWithTag(tag)?.removeFromSuperview()

                // add hostingView as subview of List
                hostingView.tag = tag
                self.addSubview(hostingView)
                
                hostingView
                    .sbu_constraint_fill(equalTo: self)
                    .sbu_constraint(height: self.frame.height)

                return true
            }
            return false
        }
    }
}
