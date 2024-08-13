//
//  OpenMutedParticipantListView+Item.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SwiftUI
import SendbirdChatSDK

extension Sendbird.View.OpenChannel.MutedParticipantList {
    /// A struct that defines the header item of the OpenMutedParticipantList view.
    public struct HeaderItem: ViewItemProtocol {
        public typealias ViewContent = OpenMutedParticipantListViewConverter.Header
        public typealias HeaderContent = ViewContent

        var viewConverter: OpenMutedParticipantListViewConverter.Header {
            get { SBViewConverterSet.OpenMutedParticipantList.header }
            set { SBViewConverterSet.OpenMutedParticipantList.header = newValue }
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
                viewController.headerComponent?.applyViewConverterForOpenMutedParticipant(.leftView)
            }
            return copy
        }
        
        public func rightView<Content: View>(
            @ViewBuilder content: @escaping (HeaderContent.RightView.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.rightView.entireContent = createViewConverter(content: content)
            copy.viewConverter.viewUpdateHandlers[.rightView] = { viewController in
                viewController.headerComponent?.applyViewConverterForOpenMutedParticipant(.rightView)
            }
            return copy
        }
        
        public func titleView<Content: View>(
            @ViewBuilder content: @escaping (HeaderContent.TitleView.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.titleView.entireContent = createViewConverter(content: content)
            copy.viewConverter.viewUpdateHandlers[.titleView] = { viewController in
                viewController.headerComponent?.applyViewConverterForOpenMutedParticipant(.titleView)
            }
            return copy
        }
    }
    
    /// A struct that defines the list item of the OpenMutedParticipantList view.
    public struct ListItem: ViewItemProtocol {
        public typealias ViewContent = OpenMutedParticipantListViewConverter.List
        public typealias ListItemContent = ViewContent.TableView.RowView
        
        var viewConverter: OpenMutedParticipantListViewConverter.List {
            get { SBViewConverterSet.OpenMutedParticipantList.list }
            set { SBViewConverterSet.OpenMutedParticipantList.list = newValue }
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
        
        public func operatorStateView<Content: View>(
            @ViewBuilder content: @escaping (ListItemContent.OperatorStateView.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.tableView.rowView.operatorStateView.entireContent = createViewConverter(content: content)
            copy.viewConverter.tableView.viewUpdateHandlers[.entireContent] = { viewController in
                viewController.listComponent?.reloadTableView()
            }
            return copy
        }
        
        public func moreButton<Content: View>(
            @ViewBuilder content: @escaping (ListItemContent.MoreButton.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.tableView.rowView.moreButton.entireContent = createViewConverter(content: content)
            copy.viewConverter.tableView.viewUpdateHandlers[.entireContent] = { viewController in
                viewController.listComponent?.reloadTableView()
            }
            return copy
        }
    }
}
