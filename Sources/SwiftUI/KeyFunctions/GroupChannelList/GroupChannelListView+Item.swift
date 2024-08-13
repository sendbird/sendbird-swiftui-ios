//
//  GroupChannelListView+Item.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SwiftUI
import SendbirdChatSDK

extension Sendbird.View.GroupChannel.ChannelList {
    /// A struct that defines the header item of the group channel list view.
    public struct HeaderItem: ViewItemProtocol {
        public typealias ViewContent = GroupChannelListViewConverter.Header
        public typealias HeaderContent = ViewContent

        var viewConverter: GroupChannelListViewConverter.Header {
            get { SBViewConverterSet.GroupChannelList.header }
            set { SBViewConverterSet.GroupChannelList.header = newValue }
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
    
    /// A struct that defines the list item of the group channel list view.
    public struct ListItem: ViewItemProtocol {
        public typealias ViewContent = GroupChannelListViewConverter.List
        public typealias ListItemContent = ViewContent.TableView.ChannelCell
        
        var viewConverter: GroupChannelListViewConverter.List {
            get { SBViewConverterSet.GroupChannelList.list }
            set { SBViewConverterSet.GroupChannelList.list = newValue }
        }
        
        public init() {}
        
        // MARK: - Public Methods
        public func rowView<Content: View>(
            @ViewBuilder content: @escaping (ListItemContent.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.tableView.channelCell.entireContent = createViewConverter(content: content)
            copy.viewConverter.tableView.channelCell.viewUpdateHandlers[.entireContent] = { vc in
                vc.listComponent?.reloadTableView()
            }
            return copy
        }
        
        public func coverImage<Content: View>(
            @ViewBuilder content: @escaping (ListItemContent.CoverImage.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.tableView.channelCell.coverImage.entireContent = createViewConverter(content: content)
            copy.viewConverter.tableView.channelCell.viewUpdateHandlers[.coverImage] = { vc in
                vc.listComponent?.reloadTableView()
            }
            return copy
        }
        
        public func channelName<Content: View>(
            @ViewBuilder content: @escaping (ListItemContent.ChannelName.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.tableView.channelCell.channelName.entireContent = createViewConverter(content: content)
            copy.viewConverter.tableView.channelCell.viewUpdateHandlers[.channelName] = { vc in
                vc.listComponent?.reloadTableView()
            }
            return copy
        }
        
        public func channelPreview<Content: View>(
            @ViewBuilder content: @escaping (ListItemContent.ChannelPreview.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.tableView.channelCell.channelPreview.entireContent = createViewConverter(content: content)
            copy.viewConverter.tableView.channelCell.viewUpdateHandlers[.channelPreview] = { vc in
                vc.listComponent?.reloadTableView()
            }
            return copy
        }
        
        public func unreadCount<Content: View>(
            @ViewBuilder content: @escaping (ListItemContent.UnreadCount.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.tableView.channelCell.unreadCount.entireContent = createViewConverter(content: content)
            copy.viewConverter.tableView.channelCell.viewUpdateHandlers[.unreadCount] = { vc in
                vc.listComponent?.reloadTableView()
            }
            return copy
        }
    }
}
