//
//  GroupChannelView+Item.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SwiftUI
import SendbirdChatSDK

extension Sendbird.View.GroupChannel.Channel {
    /// A struct that defines the header item of the GroupChannel view.
    public struct HeaderItem: ViewItemProtocol {
        public typealias ViewContent = GroupChannelViewConverter.Header
        public typealias HeaderContent = ViewContent

        var viewConverter: GroupChannelViewConverter.Header {
            get { SBViewConverterSet.GroupChannel.header }
            set { SBViewConverterSet.GroupChannel.header = newValue }
        }
        
//        func createViewConverter<Content, Config>(
//            content: @escaping (Config) -> Content
//        ) -> ViewConverter<Config> where Content : View, Config : ViewConfigurations {
//            return ViewConverter { config in
//                if shouldBeLeftAligned(config) {
//                    return UIHostingController(rootView:
//                        HStack {
//                            content(config)
//                            Spacer()
//                        }
//                    ).view
//                }
//                return UIHostingController(rootView: content(config)).view
//            }
//        }
//        
//        /// Determines if the View is a type of view that should be left aligned or not.
//        func shouldBeLeftAligned<Config: ViewConfigurations>(_ config: Config) -> Bool {
//            return config is ViewContent.TitleView.TitleLabel.ViewConfig ||
//                config is ViewContent.TitleView.StatusView.ViewConfig
//        }
        
        public init() {}
        
        // MARK: Entire Content
        // INFO: HeaderItem does not have entireContent
        
        // MARK: Item Components
        // MARK: - Public Methods
        /// HeaderItem().leftBartButton { some view }
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
        
        /// HeaderItem().rightBartButton { some view }
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
                channelTitleView?.applyViewConverter(.coverImage)
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
                channelTitleView?.applyViewConverter(.titleLabel)
            }
            return copy
        }
        
        public func typingStatusView<Content: View>(
            @ViewBuilder content: @escaping (HeaderContent.TitleView.StatusView.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.titleView.statusView.entireContent = createViewConverter(content: content)
            copy.viewConverter.titleView.statusView.viewUpdateHandlers[.entireContent] = { viewController in
                let channelTitleView = viewController.headerComponent?.titleView as? SBUChannelTitleView
                channelTitleView?.applyViewConverter(.statusView)
            }
            return copy
        }
        
    }
    
    /// A struct that defines the list item of the GroupChannel view.
    public struct ListItem: ViewItemProtocol {
        public typealias ViewContent = GroupChannelViewConverter.List
        public typealias ListItemContent = ViewContent.TableView.RowView
        
        var viewConverter: GroupChannelViewConverter.List {
            get { SBViewConverterSet.GroupChannel.list }
            set { SBViewConverterSet.GroupChannel.list = newValue }
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
        
        public func typingIndicatorView<Content: View>(
            @ViewBuilder content: @escaping (ListItemContent.TypingIndicator.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.tableView.rowView.typingMessage.entireContent = createViewConverter(content: content)
            copy.viewConverter.tableView.viewUpdateHandlers[.entireContent] = { viewController in
                viewController.listComponent?.reloadTableView()
            }
            return copy
        }
        
        public func newMessageInfoView<Content: View>(
            @ViewBuilder content: @escaping (ViewContent.NewMessageInfoView.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.newMessageInfoView.entireContent = createViewConverter(content: content)
            copy.viewConverter.newMessageInfoView.viewUpdateHandlers[.entireContent] = { viewController in
                if let newMessageInfoView = viewController.listComponent?.newMessageInfoView as? SBUNewMessageInfo {
                    newMessageInfoView.applyViewConverter(.entireContent)
                }
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
                scrollBottomView.applyViewConverter(
                    .entireContent,
                    target: listComponent,
                    action: #selector(listComponent.onTapScrollToBottom)
                )
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
                    channelStateBar.applyViewConverter(.entireContent)
                }
            }
            return copy
        }
    }
    
    // MARK: - InputItem
    public struct InputItem: ViewItemProtocol {
        public typealias ViewContent = GroupChannelViewConverter.Input
        public typealias MessageInputViewContent = GroupChannelViewConverter.Input.MessageInputView
        
//        typealias ViewContent = GroupChannelViewConverter.Input
//        public typealias ViewConverter = GroupChannelViewConverter.Input
//        public typealias MessageInputViewConverter = ViewConverter.MessageInputView
//        public typealias LeftViewConverter = ViewConverter.MessageInputView.LeftView
//        public typealias AddButtonViewConverter = ViewConverter.MessageInputView.LeftView.AddButton
//        public typealias RightViewConverter = ViewConverter.MessageInputView.RightView
//        public typealias SendButtonViewConverter = ViewConverter.MessageInputView.RightView.SendButton
//        public typealias VoiceButtonViewConverter = ViewConverter.MessageInputView.RightView.VoiceButton
        
        
        var viewConverter: GroupChannelViewConverter.Input {
            get { SBViewConverterSet.GroupChannel.input }
            set { SBViewConverterSet.GroupChannel.input = newValue }
        }
        
        public init() {}
        
        public func leftView<Content: View> (
            @ViewBuilder content: @escaping (MessageInputViewContent.LeftView.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.messageInputView.leftView.entireContent = createViewConverter(content: content)
            
            copy.viewConverter.messageInputView.leftView.viewUpdateHandlers[.entireContent] = { viewController in
                if let inputView = viewController.inputComponent?.messageInputView as? SBUMessageInputView {
                    inputView.applyViewConverter(.leftView)
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
                    inputView.applyViewConverter(.addButton)
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
                    inputView.applyViewConverter(.rightView)
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
                    inputView.applyViewConverter(.sendButton)
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
                    inputView.applyViewConverter(.voiceButton)
                }
            }
            return copy
        }
    }
}
