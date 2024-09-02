//
//  OpenChannelRegisterOperatorView+ViewConverter.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SwiftUI
import SendbirdChatSDK

extension SBURegisterOperatorModule.List {
    typealias ViewConverterForOpen = OpenChannelRegisterOperatorViewConverter.List
    
    var viewConverterForOpen: ViewConverterForOpen {
        SBViewConverterSet.OpenChannelRegisterOperator.list
    }
}

extension SBURegisterOperatorModule.List {
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