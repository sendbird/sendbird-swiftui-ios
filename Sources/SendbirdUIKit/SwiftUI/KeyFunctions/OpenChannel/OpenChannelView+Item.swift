//
//  OpenChannelView+Item.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SwiftUI
import SendbirdChatSDK

extension Sendbird.View.OpenChannel.Channel {
    /// A struct that defines the header item of the OpenChannel view.
    public struct HeaderItem: ViewItemProtocol {
        public typealias ViewContent = OpenChannelViewConverter.Header
        public typealias HeaderContent = ViewContent
        
        var viewConverter: ViewContent {
            get { SBViewConverterSet.OpenChannel.header }
            set { SBViewConverterSet.OpenChannel.header = newValue }
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
        
        public func coverImage<Content: View>(
            @ViewBuilder content: @escaping (HeaderContent.TitleView.CoverImage.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.titleView.coverImage.entireContent = createViewConverter(content: content)
            copy.viewConverter.titleView.coverImage.viewUpdateHandlers[.entireContent] = { viewController in
                let channelTitleView = viewController.headerComponent?.titleView as? SBUChannelTitleView
                channelTitleView?.applyViewConverterForOpen(.coverImage)
            }
            return copy
        }
        
        public func titleLabel<Content: View>(
            @ViewBuilder content: @escaping (HeaderContent.TitleView.TitleLabel.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.titleView.titleLabel.entireContent = createViewConverter(content: content)
            copy.viewConverter.titleView.titleLabel.viewUpdateHandlers[.entireContent] = { viewController in
                let channelTitleView = viewController.headerComponent?.titleView as? SBUChannelTitleView
                channelTitleView?.applyViewConverterForOpen(.titleLabel)
            }
            return copy
        }
        
        public func subtitleLabel<Content: View>(
            @ViewBuilder content: @escaping (HeaderContent.TitleView.SubtitleLabel.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.titleView.subtitleLabel.entireContent = createViewConverter(content: content)
            copy.viewConverter.titleView.subtitleLabel.viewUpdateHandlers[.entireContent] = { viewController in
                let channelTitleView = viewController.headerComponent?.titleView as? SBUChannelTitleView
                channelTitleView?.applyViewConverterForOpen(.subtitleLabel)
            }
            return copy
        }
    }
    
    /// A struct that defines the list item of the OpenChannel view.
    public struct ListItem: ViewItemProtocol {
        public typealias ViewContent = OpenChannelViewConverter.List
        public typealias ListItemContent = ViewContent.TableView.RowView
        
        var viewConverter: ViewContent {
            get { SBViewConverterSet.OpenChannel.list }
            set { SBViewConverterSet.OpenChannel.list = newValue }
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
        public func senderProfileImage<Content: View>(
            @ViewBuilder content: @escaping (ListItemContent.SenderProfileImage.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.tableView.rowView.senderProfileImage.entireContent = createViewConverter(content: content)
            copy.viewConverter.tableView.viewUpdateHandlers[.entireContent] = { viewController in
                viewController.listComponent?.reloadTableView()
            }
            return copy
        }
        
        public func userMessageView<Content: View>(
            @ViewBuilder content: @escaping (ListItemContent.UserMessage.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.tableView.rowView.userMessage.entireContent = createViewConverter(content: content)
            copy.viewConverter.tableView.viewUpdateHandlers[.entireContent] = { viewController in
                viewController.listComponent?.reloadTableView()
            }
            return copy
        }
        
        public func fileMessageView<Content: View>(
            @ViewBuilder content: @escaping (ListItemContent.FileMessage.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.tableView.rowView.fileMessage.entireContent = createViewConverter(content: content)
            copy.viewConverter.tableView.viewUpdateHandlers[.entireContent] = { viewController in
                viewController.listComponent?.reloadTableView()
            }
            return copy
        }
        
        public func adminMessageView<Content: View>(
            @ViewBuilder content: @escaping (ListItemContent.AdminMessage.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.tableView.rowView.adminMessage.entireContent = createViewConverter(content: content)
            copy.viewConverter.tableView.viewUpdateHandlers[.entireContent] = { viewController in
                viewController.listComponent?.reloadTableView()
            }
            return copy
        }
        
        public func scrollBottomView<Content: View>(
            @ViewBuilder content: @escaping (ViewContent.ScrollBottomView.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.scrollBottomView.entireContent = createViewConverter(content: content)
            copy.viewConverter.scrollBottomView.viewUpdateHandlers[.entireContent] = { viewController in
                guard let listComponent = viewController.listComponent,
                      let scrollBottomView = listComponent.scrollBottomView as? SBUScrollBottomView else { return }
                scrollBottomView.applyViewConverterForOpen(
                    .entireContent,
                    target: listComponent,
                    action: #selector(listComponent.onTapScrollToBottom)
                )
            }
            return copy
        }
    }
    
    // MARK: - InputItem
    public struct InputItem: ViewItemProtocol {
        public typealias ViewContent = OpenChannelViewConverter.Input
        public typealias MessageInputViewContent = OpenChannelViewConverter.Input.MessageInputView
        
        var viewConverter: ViewContent {
            get { SBViewConverterSet.OpenChannel.input }
            set { SBViewConverterSet.OpenChannel.input = newValue }
        }
        
        public init() {}
        
        public func leftView<Content: View> (
            @ViewBuilder content: @escaping (MessageInputViewContent.LeftView.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.messageInputView.leftView.entireContent = createViewConverter(content: content)
            
            copy.viewConverter.messageInputView.leftView.viewUpdateHandlers[.entireContent] = { viewController in
                if let inputView = viewController.inputComponent?.messageInputView as? SBUMessageInputView {
                    inputView.applyViewConverterForOpen(.leftView)
                }
            }
            return copy
        }
        
        public func addButton<Content: View> (
            @ViewBuilder content: @escaping (MessageInputViewContent.LeftView.AddButton.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.messageInputView.leftView.addButton.entireContent = createViewConverter(content: content)
            
            copy.viewConverter.messageInputView.leftView.addButton.viewUpdateHandlers[.entireContent] = { viewController in
                if let inputView = viewController.inputComponent?.messageInputView as? SBUMessageInputView {
                    inputView.applyViewConverterForOpen(.addButton)
                }
            }
            return copy
        }
        
        public func rightView<Content: View> (
            @ViewBuilder content: @escaping (MessageInputViewContent.RightView.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.messageInputView.rightView.entireContent = createViewConverter(content: content)
            
            copy.viewConverter.messageInputView.rightView.viewUpdateHandlers[.entireContent] = { viewController in
                if let inputView = viewController.inputComponent?.messageInputView as? SBUMessageInputView {
                    inputView.applyViewConverterForOpen(.rightView)
                }
            }
            return copy
        }
        
        public func sendButton<Content: View> (
            @ViewBuilder content: @escaping (MessageInputViewContent.RightView.SendButton.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.messageInputView.rightView.sendButton.entireContent = createViewConverter(content: content)
            
            copy.viewConverter.messageInputView.rightView.sendButton.viewUpdateHandlers[.entireContent] = { viewController in
                if let inputView = viewController.inputComponent?.messageInputView as? SBUMessageInputView {
                    inputView.applyViewConverterForOpen(.sendButton)
                }
            }
            return copy
        }
    }
}

