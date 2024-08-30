//
//  InviteUserView+ViewConverter.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SwiftUI
import SendbirdChatSDK

extension SBUInviteUserModule.List {
    typealias ViewConverter = InviteUserViewConverter.List
    
    var viewConverter: ViewConverter {
        SBViewConverterSet.InviteUser.list
    }
}

extension SBUInviteUserModule.List {
    @discardableResult
    func applyViewConverter(_ viewType: ViewConverter.ViewType) -> Bool {
        let tag = viewType.tag
        
        switch viewType {
        case .entireContent:
            if let tableViewConverter = self.viewConverter.tableView.entireContent,
               let users = self.userList,
               let hostingView = tableViewConverter(
                .init(
                    parentView: self,
                    users: users,
                    selectedUsers: Array(self.selectedUserList ?? [])
                )
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

extension SBUInviteUserModule.List {
    public func onSelectUser(_ user: SBUUser) {
        self.delegate?.inviteUserModule(self, didSelectUser: user)
    }
}
