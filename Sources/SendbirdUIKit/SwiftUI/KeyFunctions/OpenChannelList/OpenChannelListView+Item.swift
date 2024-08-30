//
//  OpenChannelListView+Item.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SwiftUI
import SendbirdChatSDK

extension Sendbird.View.OpenChannel.ChannelList {
    /// A struct that defines the header item of the OpenChannelList view.
    public struct HeaderItem: ViewItemProtocol {
        public typealias ViewContent = OpenChannelListViewConverter.Header
        public typealias HeaderContent = ViewContent

        var viewConverter: OpenChannelListViewConverter.Header {
            get { SBViewConverterSet.OpenChannelList.header }
            set { SBViewConverterSet.OpenChannelList.header = newValue }
        }
        
        public init() {}
        
        // MARK: Entire Content
        // INFO: HeaderItem does not have entireContent
        
        // MARK: Item Components
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
    
    /// A struct that defines the list item of the OpenChannelList view.
    public struct ListItem: ViewItemProtocol {
        public typealias ViewContent = OpenChannelListViewConverter.List
        public typealias ListItemContent = ViewContent.TableView.ChannelCell
        
        var viewConverter: OpenChannelListViewConverter.List {
            get { SBViewConverterSet.OpenChannelList.list }
            set { SBViewConverterSet.OpenChannelList.list = newValue }
        }
        
        public init() {}
        
        // MARK: Entire Content
        
        public func rowView<Content: View>(
            @ViewBuilder content: @escaping (ListItemContent.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.tableView.channelCell.entireContent = createViewConverter(content: content)
            copy.viewConverter.tableView.channelCell.viewUpdateHandlers[.entireContent] = { viewController in
                viewController.listComponent?.reloadTableView()
            }
            return copy
        }
        
        // MARK: Item Components
        
        public func coverImage<Content: View>(
            @ViewBuilder content: @escaping (ListItemContent.CoverImage.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.tableView.channelCell.coverImage.entireContent = createViewConverter(content: content)
            copy.viewConverter.tableView.channelCell.viewUpdateHandlers[.coverImage] = { viewController in
                viewController.listComponent?.reloadTableView()
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
            return self
        }
        
        public func channelPreview<Content: View>(
            @ViewBuilder content: @escaping (ListItemContent.ChannelPreview.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.tableView.channelCell.channelPreview.entireContent = createViewConverter(content: content)
            copy.viewConverter.tableView.channelCell.viewUpdateHandlers[.channelPreview] = { vc in
                vc.listComponent?.reloadTableView()
            }
            return self
        }
    }
}
