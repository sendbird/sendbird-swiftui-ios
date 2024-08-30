//
//  MessageThreadView+Item.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SwiftUI
import SendbirdChatSDK

extension Sendbird.View.GroupChannel.MessageThread {
    // MARK: - HeaderItem
    /// A struct that defines the header item of the MessageThread view.
    public struct HeaderItem: ViewItemProtocol {
        public typealias ViewContent = MessageThreadViewConverter.Header
        public typealias HeaderContent = ViewContent
        
        var viewConverter: ViewContent {
            get { SBViewConverterSet.MessageThread.header }
            set { SBViewConverterSet.MessageThread.header = newValue }
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
        
        public func titleLabel<Content: View>(
            @ViewBuilder content: @escaping (HeaderContent.TitleView.TitleLabel.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.titleView.titleLabel.entireContent = createViewConverter(content: content)
            copy.viewConverter.titleView.titleLabel.viewUpdateHandlers[.entireContent] = { viewController in
                let channelTitleView = viewController.headerComponent?.titleView as? SBUMessageThreadTitleView
                channelTitleView?.applyViewConverter(.titleLabel)
            }
            return copy
        }
        
        public func subtitleLabel<Content: View>(
            @ViewBuilder content: @escaping (HeaderContent.TitleView.SubtitleLabel.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.titleView.subtitleLabel.entireContent = createViewConverter(content: content)
            copy.viewConverter.titleView.subtitleLabel.viewUpdateHandlers[.entireContent] = { viewController in
                let channelTitleView = viewController.headerComponent?.titleView as? SBUMessageThreadTitleView
                channelTitleView?.applyViewConverter(.subtitleLabel)
            }
            return copy
        }
    }
    
    // MARK: - ParentInfoItem
    public struct ParentInfoItem: ViewItemProtocol {
        public typealias ViewContent = MessageThreadViewConverter.ParentInfo
        public typealias ListItemContent = ViewContent
        
        var viewConverter: ViewContent {
            get { SBViewConverterSet.MessageThread.parentInfo }
            set { SBViewConverterSet.MessageThread.parentInfo = newValue }
        }
        
        public init() {}
        
        // MARK: Entire Content
        
        public func parentInfoView<Content: View>(
            @ViewBuilder content: @escaping (ListItemContent.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.entireContent = createViewConverter(content: content)
            copy.viewConverter.viewUpdateHandlers[.entireContent] = { viewController in
                if let parentInfoView = viewController.listComponent?.parentMessageInfoView as? SBUParentMessageInfoView {
                    parentInfoView.applyViewConverter(.entireContent)
                }
            }
            return copy
        }
        
        public func profileView<Content: View>(
            @ViewBuilder content: @escaping (ListItemContent.ProfileView.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.profileView.entireContent = createViewConverter(content: content)
            copy.viewConverter.profileView.viewUpdateHandlers[.entireContent] = { viewController in
                let parentInfoView = viewController.listComponent?.parentMessageInfoView as? SBUParentMessageInfoView
                parentInfoView?.applyViewConverter(.profileView)
            }
            return copy
        }
        
        public func userNameLabel<Content: View>(
            @ViewBuilder content: @escaping (ListItemContent.UserNameLabel.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.userNameLabel.entireContent = createViewConverter(content: content)
            copy.viewConverter.userNameLabel.viewUpdateHandlers[.entireContent] = { viewController in
                let parentInfoView = viewController.listComponent?.parentMessageInfoView as? SBUParentMessageInfoView
                parentInfoView?.applyViewConverter(.userNameLabel)
            }
            return copy
        }
        
        public func dateLabel<Content: View>(
            @ViewBuilder content: @escaping (ListItemContent.DateLabel.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.dateLabel.entireContent = createViewConverter(content: content)
            copy.viewConverter.dateLabel.viewUpdateHandlers[.entireContent] = { viewController in
                let parentInfoView = viewController.listComponent?.parentMessageInfoView as? SBUParentMessageInfoView
                parentInfoView?.applyViewConverter(.dateLabel)
            }
            return copy
        }
        
        public func moreButton<Content: View>(
            @ViewBuilder content: @escaping (ListItemContent.MoreButton.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.moreButton.entireContent = createViewConverter(content: content)
            copy.viewConverter.moreButton.viewUpdateHandlers[.entireContent] = { viewController in
                let parentInfoView = viewController.listComponent?.parentMessageInfoView as? SBUParentMessageInfoView
                parentInfoView?.applyViewConverter(.moreButton)
            }
            return copy
        }
        
        public func replyLabel<Content: View>(
            @ViewBuilder content: @escaping (ListItemContent.ReplyLabel.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.replyLabel.entireContent = createViewConverter(content: content)
            copy.viewConverter.replyLabel.viewUpdateHandlers[.entireContent] = { viewController in
                let parentInfoView = viewController.listComponent?.parentMessageInfoView as? SBUParentMessageInfoView
                parentInfoView?.applyViewConverter(.replyLabel)
            }
            return copy
        }
        
        public func messageTextView<Content: View>(
            @ViewBuilder content: @escaping (ListItemContent.MessageTextView.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.messageTextView.entireContent = createViewConverter(content: content)
            copy.viewConverter.messageTextView.viewUpdateHandlers[.entireContent] = { viewController in
                let parentInfoView = viewController.listComponent?.parentMessageInfoView as? SBUParentMessageInfoView
                parentInfoView?.applyViewConverter(.messageTextView)
            }
            return copy
        }
        
        public func fileContentView<Content: View>(
            @ViewBuilder content: @escaping (ListItemContent.FileContentView.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.fileContentView.entireContent = createViewConverter(content: content)
            copy.viewConverter.fileContentView.viewUpdateHandlers[.entireContent] = { viewController in
                let parentInfoView = viewController.listComponent?.parentMessageInfoView as? SBUParentMessageInfoView
                parentInfoView?.applyViewConverter(.fileContentView)
            }
            return copy
        }
        
        public func multipleFilesContentView<Content: View>(
            @ViewBuilder content: @escaping (ListItemContent.MultipleFileContentView.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.multipleFileContentView.entireContent = createViewConverter(content: content)
            copy.viewConverter.multipleFileContentView.viewUpdateHandlers[.entireContent] = { viewController in
                let parentInfoView = viewController.listComponent?.parentMessageInfoView as? SBUParentMessageInfoView
                parentInfoView?.applyViewConverter(.multipleFileContentView)
            }
            return copy
        }
        
        public func webView<Content: View>(
            @ViewBuilder content: @escaping (ListItemContent.WebView.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.webView.entireContent = createViewConverter(content: content)
            copy.viewConverter.webView.viewUpdateHandlers[.entireContent] = { viewController in
                let parentInfoView = viewController.listComponent?.parentMessageInfoView as? SBUParentMessageInfoView
                parentInfoView?.applyViewConverter(.webView)
            }
            return copy
        }
        
        public func reactionView<Content: View>(
            @ViewBuilder content: @escaping (ListItemContent.ReactionView.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.reactionView.entireContent = createViewConverter(content: content)
            copy.viewConverter.reactionView.viewUpdateHandlers[.entireContent] = { viewController in
                let parentInfoView = viewController.listComponent?.parentMessageInfoView as? SBUParentMessageInfoView
                parentInfoView?.applyViewConverter(.reactionView)
            }
            return copy
        }
    }
    
    // MARK: - ListItem
    /// A struct that defines the list item of the MessageThread  view.
    public struct ListItem: ViewItemProtocol {
        public typealias ViewContent = MessageThreadViewConverter.List
        public typealias ListItemContent = ViewContent.TableView.RowView
        
        var viewConverter: ViewContent {
            get { SBViewConverterSet.MessageThread.list }
            set { SBViewConverterSet.MessageThread.list = newValue }
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
        
        /// Customizes the UserMessageView's text area.
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
        
        /// Customizes the FileMessageView's file content area.
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
        
        public func multipleFilesMessageView<Content: View>(
            @ViewBuilder content: @escaping (ListItemContent.MultipleFilesMessage.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.tableView.rowView.multipleFilesMessage.entireContent = createViewConverter(content: content)
            copy.viewConverter.tableView.viewUpdateHandlers[.entireContent] = { viewController in
                viewController.listComponent?.reloadTableView()
            }
            return copy
        }
        
        public func channelStateBanner<Content: View>(
            @ViewBuilder content: @escaping (ViewContent.ChannelStateBar.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.channelStateBar.entireContent = createViewConverter(content: content)
            copy.viewConverter.channelStateBar.viewUpdateHandlers[.entireContent] = { viewController in
                if let channelStateBar = viewController.listComponent?.channelStateBanner as? SBUChannelStateBanner {
                    channelStateBar.applyViewConverterForMessageThread(.entireContent)
                }
            }
            return copy
        }
    }
    
    // MARK: - InputItem
    public struct InputItem: ViewItemProtocol {
        public typealias ViewContent = MessageThreadViewConverter.Input
        public typealias MessageInputViewContent = MessageThreadViewConverter.Input.MessageInputView
        
        var viewConverter: ViewContent {
            get { SBViewConverterSet.MessageThread.input }
            set { SBViewConverterSet.MessageThread.input = newValue }
        }
        
        public init() {}
        
        public func leftView<Content: View> (
            @ViewBuilder content: @escaping (MessageInputViewContent.LeftView.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.messageInputView.leftView.entireContent = createViewConverter(content: content)
            
            copy.viewConverter.messageInputView.leftView.viewUpdateHandlers[.entireContent] = { viewController in
                if let inputView = viewController.inputComponent?.messageInputView as? SBUMessageInputView {
                    inputView.applyViewConverterForThread(.leftView)
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
                    inputView.applyViewConverterForThread(.addButton)
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
                    inputView.applyViewConverterForThread(.rightView)
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
                    inputView.applyViewConverterForThread(.sendButton)
                }
            }
            return copy
        }
        
        public func voiceButton<Content: View> (
            @ViewBuilder content: @escaping (MessageInputViewContent.RightView.VoiceButton.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.messageInputView.rightView.voiceButton.entireContent = createViewConverter(content: content)
            
            copy.viewConverter.messageInputView.rightView.voiceButton.viewUpdateHandlers[.entireContent] = { viewController in
                if let inputView = viewController.inputComponent?.messageInputView as? SBUMessageInputView {
                    inputView.applyViewConverterForThread(.voiceButton)
                }
            }
            return copy
        }
    }
}


