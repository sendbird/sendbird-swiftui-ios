//
//  GroupChannelSettingsView+ViewConverter.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SwiftUI
import SendbirdChatSDK

extension SBUGroupChannelSettingsModule.List {
    typealias ViewConverter = GroupChannelSettingsViewConverter.List.TableView
    
    var viewConverter: ViewConverter {
        SBViewConverterSet.GroupChannelSettings.list.tableView
    }
}

extension SBUGroupChannelSettingsModule.List {
    func applyViewConverter(_ viewType: ViewConverter.ViewType) -> Bool {
        let tag = viewType.tag
        
        switch viewType {
        case .entireContent:
            if let groupChannel = self.channel,
               let tableViewConverter = self.viewConverter.entireContent,
               let hostingView = tableViewConverter(.init(parentView: self, channel: groupChannel)) {
                
                // remove UITableView
                self.tableView.removeFromSuperview()
                
                // add hostingView as subview of List
                hostingView.tag = tag
                self.addSubview(hostingView)
                hostingView.sbu_constraint_fill(equalTo: self)
                
                return true
            }
        case .channelInfo:
            if let groupChannel = self.channel,
               let channelInfoConverter = self.viewConverter.channelInfo.entireContent,
               let hostingView = channelInfoConverter(.init(channel: groupChannel)) {
                if let infoView = self.channelInfoView as? SBUChannelSettingsChannelInfoView {
                    infoView.subviews.forEach {
                        if $0 != infoView.stackView && $0 != infoView.lineView {
                            $0.removeFromSuperview()
                        }
                    }
                    infoView.stackView.subviews.forEach {
                        $0.removeFromSuperview()
                    }
                    infoView.viewWithTag(tag)?.removeFromSuperview()
                    
                    hostingView.tag = tag
                    // Add the hostingView to the stackView
                    infoView.stackView.addArrangedSubview(hostingView)
                    hostingView.sbu_constraint(equalTo: infoView.stackView, leading: 0, trailing: 0, top: 0, bottom: 0)
                }
                
                return true
            }
        }
        
        return false
    }
}
