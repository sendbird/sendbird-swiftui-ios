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
        /// The view content type for the header of the group channel list.
        public typealias ViewContent = GroupChannelListViewConverter.Header
        /// The header content type alias for the view content.
        public typealias HeaderContent = ViewContent

        var viewConverter: GroupChannelListViewConverter.Header {
            get { SBViewConverterSet.GroupChannelList.header }
            set { SBViewConverterSet.GroupChannelList.header = newValue }
        }

        /// Initializes a new `HeaderItem` with default values.
        public init() {}

        // MARK: Entire Content
        // INFO: HeaderItem does not have entireContent

        // MARK: Item Components
        // MARK: - Public Methods
        /// Customizes the left view of the header using the provided content builder.
        /// - Parameter content: A view builder that creates the left view from its configuration.
        /// - Returns: A modified `HeaderItem` with the custom left view applied.
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
        
        /// Customizes the right view of the header using the provided content builder.
        /// - Parameter content: A view builder that creates the right view from its configuration.
        /// - Returns: A modified `HeaderItem` with the custom right view applied.
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
        
        /// Customizes the title view of the header using the provided content builder.
        /// - Parameter content: A view builder that creates the title view from its configuration.
        /// - Returns: A modified `HeaderItem` with the custom title view applied.
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
        /// The view content type for the list of the group channel list.
        public typealias ViewContent = GroupChannelListViewConverter.List
        /// The list item content type alias for the channel cell.
        public typealias ListItemContent = ViewContent.TableView.ChannelCell

        var viewConverter: GroupChannelListViewConverter.List {
            get { SBViewConverterSet.GroupChannelList.list }
            set { SBViewConverterSet.GroupChannelList.list = newValue }
        }

        /// Initializes a new `ListItem` with default values.
        public init() {}

        // MARK: - Public Methods
        /// Customizes the row view of a channel cell using the provided content builder.
        /// - Parameter content: A view builder that creates the row view from its configuration.
        /// - Returns: A modified `ListItem` with the custom row view applied.
        public func rowView<Content: View>(
            @ViewBuilder content: @escaping (ListItemContent.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.tableView.channelCell.entireContent = createViewConverter(content: content)
            // swiftlint:disable:next identifier_name
            copy.viewConverter.tableView.channelCell.viewUpdateHandlers[.entireContent] = { vc in
                vc.listComponent?.reloadTableView()
            }
            return copy
        }

        /// Customizes the cover image of a channel cell using the provided content builder.
        /// - Parameter content: A view builder that creates the cover image from its configuration.
        /// - Returns: A modified `ListItem` with the custom cover image applied.
        public func coverImage<Content: View>(
            @ViewBuilder content: @escaping (ListItemContent.CoverImage.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.tableView.channelCell.coverImage.entireContent = createViewConverter(content: content)
            // swiftlint:disable:next identifier_name
            copy.viewConverter.tableView.channelCell.viewUpdateHandlers[.coverImage] = { vc in
                vc.listComponent?.reloadTableView()
            }
            return copy
        }
        
        /// Customizes the channel name of a channel cell using the provided content builder.
        /// - Parameter content: A view builder that creates the channel name view from its configuration.
        /// - Returns: A modified `ListItem` with the custom channel name applied.
        public func channelName<Content: View>(
            @ViewBuilder content: @escaping (ListItemContent.ChannelName.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.tableView.channelCell.channelName.entireContent = createViewConverter(content: content)
            // swiftlint:disable:next identifier_name
            copy.viewConverter.tableView.channelCell.viewUpdateHandlers[.channelName] = { vc in
                vc.listComponent?.reloadTableView()
            }
            return copy
        }
        
        /// Customizes the channel preview of a channel cell using the provided content builder.
        /// - Parameter content: A view builder that creates the channel preview from its configuration.
        /// - Returns: A modified `ListItem` with the custom channel preview applied.
        public func channelPreview<Content: View>(
            @ViewBuilder content: @escaping (ListItemContent.ChannelPreview.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.tableView.channelCell.channelPreview.entireContent = createViewConverter(content: content)
            // swiftlint:disable:next identifier_name
            copy.viewConverter.tableView.channelCell.viewUpdateHandlers[.channelPreview] = { vc in
                vc.listComponent?.reloadTableView()
            }
            return copy
        }
        
        /// Customizes the unread count badge of a channel cell using the provided content builder.
        /// - Parameter content: A view builder that creates the unread count view from its configuration.
        /// - Returns: A modified `ListItem` with the custom unread count view applied.
        public func unreadCount<Content: View>(
            @ViewBuilder content: @escaping (ListItemContent.UnreadCount.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.tableView.channelCell.unreadCount.entireContent = createViewConverter(content: content)
            // swiftlint:disable:next identifier_name
            copy.viewConverter.tableView.channelCell.viewUpdateHandlers[.unreadCount] = { vc in
                vc.listComponent?.reloadTableView()
            }
            return copy
        }
    }
}
