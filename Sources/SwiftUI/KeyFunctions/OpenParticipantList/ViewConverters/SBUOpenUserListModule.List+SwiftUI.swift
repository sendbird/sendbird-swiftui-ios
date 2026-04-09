//
//  OpenParticipantListView+ViewConverter.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SwiftUI
import SendbirdChatSDK

// FIXME: groupChannel 쪽이랑 같은 module 을 사용해서 중복. 이후 여기도 처리해야함
extension SBUUserListModule.List {
    typealias ViewConverterForOpen = OpenParticipantListViewConverter.List
    
    var viewConverterForOpen: ViewConverterForOpen {
        SBViewConverterSet.OpenParticipantList.list
    }
}

extension SBUUserListModule.List {
    func applyViewConverterForOpen(_ viewType: ViewConverterForOpen.ViewType) -> Bool {
        let tag = viewType.tag
        
        switch viewType {
        case .entireContent:
            if let tableViewConverter = self.viewConverter.tableView.entireContent,
               let hostingView = tableViewConverter(
                .init()
               ) {
            
                // remove UITableView
                self.tableView.removeFromSuperview()
                
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
