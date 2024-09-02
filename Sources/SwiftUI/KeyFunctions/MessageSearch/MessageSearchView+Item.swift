//
//  MessageSearchView+Item.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SwiftUI
import SendbirdChatSDK

extension Sendbird.View.GroupChannel.MessageSearch {
    /// A struct that defines the header item of the MessageSearch view.
    struct HeaderItem: ViewItemProtocol {
        public typealias ViewContent = MessageSearchViewConverter.Header
        public typealias HeaderContent = ViewContent

        var viewConverter: MessageSearchViewConverter.Header {
            get { SBViewConverterSet.MessageSearch.header }
            set { SBViewConverterSet.MessageSearch.header = newValue }
        }
        
        public init() {}
        
        // MARK: Entire Content
        // INFO: HeaderItem does not have entireContent
        
        // MARK: Item Components
        // MARK: - Public Methods
        // NOTE: `MessageSearchView`'s `leftView` customization interface has been temporarily closed.
        func leftView<Content: View>(
            @ViewBuilder content: @escaping (HeaderContent.LeftView.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.leftView.entireContent = createViewConverter(content: content)
            copy.viewConverter.viewUpdateHandlers[.leftView] = { viewController in
                viewController.headerComponent?.applyViewConverter(.leftView)
            }
            return copy
        }
        
        // NOTE: `MessageSearchView`'s `rightView` customization interface has been temporarily closed.
        func rightView<Content: View>(
            @ViewBuilder content: @escaping (HeaderContent.RightView.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.rightView.entireContent = createViewConverter(content: content)
            copy.viewConverter.viewUpdateHandlers[.rightView] = { viewController in
                viewController.headerComponent?.applyViewConverter(.rightView)
            }
            return copy
        }
        
        // NOTE: `MessageSearchView`'s `titleView` customization interface has been temporarily closed.
        func titleView<Content: View>(
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
    
    /// A struct that defines the list item of the MessageSearch view.
    public struct ListItem: ViewItemProtocol {
        public typealias ViewContent = MessageSearchViewConverter.List
        // TODO: 필요하면 구현 (↓↓ example ↓↓)
        // public typealias ListItemContent = ViewContent.TableView.ChannelCell
        
        var viewConverter: MessageSearchViewConverter.List {
            get { SBViewConverterSet.MessageSearch.list }
            set { SBViewConverterSet.MessageSearch.list = newValue }
        }
        
        public init() {}
        
        // MARK: Entire Content
// (↓↓ example ↓↓)
//        public func channelListRow<Content: View>(
//            @ViewBuilder content: @escaping (ListItemContent.ViewConfig) -> Content
//        ) -> Self {
//            var copy = self
//            copy.viewConverter.tableView.channelCell.entireContent = createViewConverter(content: content)
//            copy.viewConverter.tableView.channelCell.viewUpdateHandlers[.entireContent] = { viewController in
//                viewController.listComponent?.reloadTableView()
//            }
//            return copy
//        }
        
        // MARK: Item Components
// (↓↓ example ↓↓)
//        public func coverImage<Content: View>(
//            @ViewBuilder content: @escaping (ListItemContent.CoverImage.ViewConfig) -> Content
//        ) -> Self {
//            var copy = self
//            copy.viewConverter.tableView.channelCell.coverImage.entireContent = createViewConverter(content: content)
//            copy.viewConverter.tableView.channelCell.coverImage.viewUpdateHandlers[.entireContent] = { viewController in
//                viewController.listComponent?.reloadTableView()
//            }
//            return copy
//        }
    }
    
    // TODO: Header, List 외에 필요한 ViewItem 이 있다면 계속 구현
}