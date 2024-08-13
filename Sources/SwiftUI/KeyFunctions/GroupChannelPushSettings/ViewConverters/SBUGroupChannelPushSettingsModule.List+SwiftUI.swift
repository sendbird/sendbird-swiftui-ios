//
//  GroupChannelPushSettingsView+ViewConverter.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SwiftUI
import SendbirdChatSDK

extension SBUGroupChannelPushSettingsModule.List {
    typealias ViewConverter = GroupChannelPushSettingsViewConverter.List
    
    var viewConverter: ViewConverter {
        SBViewConverterSet.GroupChannelPushSettings.list
    }
}

extension SBUGroupChannelPushSettingsModule.List {
    func applyViewConverter(_ viewType: ViewConverter.ViewType) -> Bool {
        let tag = viewType.tag
        
        switch viewType {
        case .entireContent:
            if let tableViewConverter = self.viewConverter.entireContent,
               let hostingView = tableViewConverter(.init(parentView: self)) {
                // TODO: 위에 initializer 에 파라미터가 필요하면 추가
                
                // remove UITableView
                self.tableView.removeFromSuperview()
                
                // add hostingView as subview of List
                hostingView.tag = tag
                self.addSubview(hostingView)
                hostingView.sbu_constraint_fill(equalTo: self)
                
                return true
            }
            return false
        }
    }
}
