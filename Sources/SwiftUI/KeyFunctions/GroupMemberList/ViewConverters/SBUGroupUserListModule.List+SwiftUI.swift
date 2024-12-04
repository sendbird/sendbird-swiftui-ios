//
//  GroupMemberListView+ViewConverter.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SwiftUI
import SendbirdChatSDK

extension SBUUserListModule.List {
    typealias ViewConverter = GroupMemberListViewConverter.List
    
    var viewConverter: ViewConverter {
        SBViewConverterSet.GroupMemberList.list
    }
}

extension SBUUserListModule.List {
    func applyViewConverter(_ viewType: ViewConverter.ViewType) -> Bool {
        let tag = viewType.tag
        switch viewType {
        case .entireContent:
            // TODO: EntireContent
            if self.viewWithTag(tag) != nil {
                return true
            }
            
            if let tableViewConverter = self.viewConverter.tableView.entireContent,
               let hostingView = tableViewConverter(.init()) {
                hostingView.backgroundColor = .blue
            
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
    
    private func updateHostingViewData(users: [SBUUser]) {
        // 여기서 hostingView 내부의 SwiftUI view에 userList와 관련된 데이터를 업데이트합니다.
    }
}
