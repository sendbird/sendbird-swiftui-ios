//
//  InviteUserView+Item.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SwiftUI
import SendbirdChatSDK

extension Sendbird.View.GroupChannel.InviteUser {
    /// A struct that defines the header item of the InviteUser view.
    public struct HeaderItem: ViewItemProtocol {
        public typealias ViewContent = InviteUserViewConverter.Header
        public typealias HeaderContent = ViewContent

        var viewConverter: InviteUserViewConverter.Header {
            get { SBViewConverterSet.InviteUser.header }
            set { SBViewConverterSet.InviteUser.header = newValue }
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
            copy.viewConverter.leftView.viewUpdateHandlers[.entireContent] = { viewController in
                viewController.headerComponent?.applyViewConverter(.leftView)
            }
            return copy
        }
        
        public func rightView<Content: View>(
            @ViewBuilder content: @escaping (HeaderContent.RightView.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.rightView.entireContent = createViewConverter(content: content)
            copy.viewConverter.rightView.viewUpdateHandlers[.entireContent] = { viewController in
                viewController.headerComponent?.applyViewConverter(.rightView)
            }
            return copy
        }
        
        public func titleView<Content: View>(
            @ViewBuilder content: @escaping (HeaderContent.TitleView.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.titleView.entireContent = createViewConverter(content: content)
            copy.viewConverter.titleView.viewUpdateHandlers[.entireContent] = { viewController in
                viewController.headerComponent?.applyViewConverter(.titleView)
            }
            return copy
        }
    }
    
    /// A struct that defines the list item of the InviteUser view.
    public struct ListItem: ViewItemProtocol {
        public typealias ViewContent = InviteUserViewConverter.List
        public typealias ListItemContent = ViewContent.TableView.RowView
        
        var viewConverter: InviteUserViewConverter.List {
            get { SBViewConverterSet.InviteUser.list }
            set { SBViewConverterSet.InviteUser.list = newValue }
        }
        
        public init() {}
        
        // MARK: Entire Content
        public func rowView<Content: View>(
            @ViewBuilder content: @escaping (ListItemContent.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.tableView.rowView.entireContent = createViewConverter(content: content)
            copy.viewConverter.tableView.viewUpdateHandlers[.entireContent] = { viewController in
                viewController.listComponent?.reloadTableView()
            }
            return copy
        }
        
        // MARK: Item Components
        public func profileImage<Content: View>(
            @ViewBuilder content: @escaping (ListItemContent.ProfileImage.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.tableView.rowView.profileImage.entireContent = createViewConverter(content: content)
            copy.viewConverter.tableView.viewUpdateHandlers[.entireContent] = { viewController in
                viewController.listComponent?.reloadTableView()
            }
            return copy
        }
        
        public func userName<Content: View>(
            @ViewBuilder content: @escaping (ListItemContent.UserNameLabel.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.tableView.rowView.userNameLabel.entireContent = createViewConverter(content: content)
            copy.viewConverter.tableView.viewUpdateHandlers[.entireContent] = { viewController in
                viewController.listComponent?.reloadTableView()
            }
            return copy
        }
        
        public func selectionButton<Content: View>(
            @ViewBuilder content: @escaping (ListItemContent.SelectionButton.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.tableView.rowView.selectionButton.entireContent = createViewConverter(content: content)
            copy.viewConverter.tableView.viewUpdateHandlers[.entireContent] = { viewController in
                viewController.listComponent?.reloadTableView()
            }
            return copy
        }
    }
}
