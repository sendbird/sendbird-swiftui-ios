//
//  OpenModerationsView+ViewConverter.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SwiftUI
import SendbirdChatSDK

extension SBUModerationsModule.List {
    typealias ViewConverterForOpen = OpenModerationsViewConverter.List
    
    var viewConverterForOpen: ViewConverterForOpen {
        SBViewConverterSet.OpenModerations.list
    }
}

extension SBUModerationsModule.List {
    func applyViewConverterForOpen(_ viewType: ViewConverterForOpen.ViewType) -> Bool {
        let tag = viewType.tag
        
        switch viewType {
        case .entireContent:
            if let tableViewConverter = self.viewConverterForOpen.entireContent,
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
