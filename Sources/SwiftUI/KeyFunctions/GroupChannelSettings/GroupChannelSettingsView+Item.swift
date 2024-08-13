//
//  GroupChannelSettingsView+Item.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SwiftUI
import SendbirdChatSDK

extension Sendbird.View.GroupChannel.Settings {
    /// A struct that defines the header item of the GroupChannelSettings view.
    public struct HeaderItem: ViewItemProtocol {
        public typealias ViewContent = GroupChannelSettingsViewConverter.Header
        public typealias HeaderContent = ViewContent

        var viewConverter: GroupChannelSettingsViewConverter.Header {
            get { SBViewConverterSet.GroupChannelSettings.header }
            set { SBViewConverterSet.GroupChannelSettings.header = newValue }
        }
        
        public init() {}
        
        // MARK: Entire Content
        // INFO: HeaderItem does not have entireContent
        
        // MARK: Item Components
        // MARK: - Public Methods
        public func leftView<Content: View>(
            @ViewBuilder content: @escaping (HeaderContent.LeftView.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.leftView.entireContent = createViewConverter(content: content)
            copy.viewConverter.viewUpdateHandlers[.leftView] = { viewController in
                viewController.headerComponent?.applyViewConverter(.leftView)
            }
            return copy
        }
        
        public func rightView<Content: View>(
            @ViewBuilder content: @escaping (HeaderContent.RightView.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.rightView.entireContent = createViewConverter(content: content)
            copy.viewConverter.viewUpdateHandlers[.rightView] = { viewController in
                viewController.headerComponent?.applyViewConverter(.rightView)
            }
            return copy
        }
        
        public func titleView<Content: View>(
            @ViewBuilder content: @escaping (HeaderContent.TitleView.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.titleView.entireContent = createViewConverter(content: content)
            copy.viewConverter.viewUpdateHandlers[.titleView] = { viewController in
                viewController.headerComponent?.applyViewConverter(.titleView)
            }
            return copy
        }
    }
    
    /// A struct that defines the list item of the GroupChannelSettings view.
    public struct ListItem: ViewItemProtocol {
        public typealias ViewContent = GroupChannelSettingsViewConverter.List
        public typealias ListItemContent = ViewContent.TableView
        
        var viewConverter: GroupChannelSettingsViewConverter.List {
            get { SBViewConverterSet.GroupChannelSettings.list }
            set { SBViewConverterSet.GroupChannelSettings.list = newValue }
        }
        
        public init() {}
        
        public func channelInfo(
            @ViewBuilder content: @escaping (ListItemContent.ChannelInfo.ViewConfig) -> some View
        ) -> Self {
            var copy = self
            copy.viewConverter.tableView.channelInfo.entireContent = createViewConverter(content: content)
            copy.viewConverter.tableView.viewUpdateHandlers[.entireContent] = { viewController in
                viewController.listComponent?.reloadTableView()
            }
            
            return copy
        }
        
        public func moderationRow(
            @ViewBuilder content: @escaping (ListItemContent.SettingCell.Moderation.ViewConfig) -> some View
        ) -> Self {
            var copy = self
            copy.viewConverter.tableView.settingCell.moderation.entireContent = createViewConverter(content: content)
            copy.viewConverter.tableView.viewUpdateHandlers[.entireContent] = { viewController in
                viewController.listComponent?.reloadTableView()
            }
            
            return copy
        }
        
        public func notificationRow(
            @ViewBuilder content: @escaping (ListItemContent.SettingCell.Notification.ViewConfig) -> some View
        ) -> Self {
            var copy = self
            copy.viewConverter.tableView.settingCell.notification.entireContent = createViewConverter(content: content)
            copy.viewConverter.tableView.viewUpdateHandlers[.entireContent] = { viewController in
                viewController.listComponent?.reloadTableView()
            }
            
            return copy
        }
        
        public func memberRow(
            @ViewBuilder content: @escaping (ListItemContent.SettingCell.Member.ViewConfig) -> some View
        ) -> Self {
            var copy = self
            copy.viewConverter.tableView.settingCell.member.entireContent = createViewConverter(content: content)
            copy.viewConverter.tableView.viewUpdateHandlers[.entireContent] = { viewController in
                viewController.listComponent?.reloadTableView()
            }
            
            return copy
        }
        
        public func searchRow(
            @ViewBuilder content: @escaping (ListItemContent.SettingCell.SearchItem.ViewConfig) -> some View
        ) -> Self {
            var copy = self
            copy.viewConverter.tableView.settingCell.searchItem.entireContent = createViewConverter(content: content)
            copy.viewConverter.tableView.viewUpdateHandlers[.entireContent]  = { viewController in
                viewController.listComponent?.reloadTableView()
            }
            
            return copy
        }
        
        public func leaveChannelRow(
            @ViewBuilder content: @escaping (ListItemContent.SettingCell.LeaveChannel.ViewConfig) -> some View
        ) -> Self {
            var copy = self
            copy.viewConverter.tableView.settingCell.leaveChannel.entireContent = createViewConverter(content: content)
            copy.viewConverter.tableView.viewUpdateHandlers[.entireContent]  = { viewController in
                viewController.listComponent?.reloadTableView()
            }
            
            return copy
        }
    }
}
