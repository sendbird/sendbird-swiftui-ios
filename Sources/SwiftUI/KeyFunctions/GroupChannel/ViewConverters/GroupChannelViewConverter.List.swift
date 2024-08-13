//
//  GroupChannelView+ViewConverter.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SendbirdChatSDK
import UIKit

// MARK: List
extension GroupChannelViewConverter {
    public struct List: ViewConverterProtocol {
        // MARK: TypeAlias
        public typealias ContentBaseArg = SBUGroupChannelModule.List
        typealias UpdatableVC = SBUGroupChannelViewController

        // MARK: ViewType
        enum ViewType: ViewTypeEnum {
            case none
        }

        // MARK: Converter
        /// Never used. Use `TableView.entireContent` instead.
        var entireContent: ViewConverter<ViewConfig>?
        var tableView = TableView() // SBUGroupChannelModule.List+SwiftUI
        var newMessageInfoView = NewMessageInfoView() // SBUNewMessageInfo+SwiftUI
        var scrollBottomView = ScrollBottomView() // SBUScrollBottomView+SwiftUI+SwiftUI
        var channelStateBar = ChannelStateBar() // SBUChannelStateBanner+SwiftUI+SwiftUI

        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {
            public var parentView: ContentBaseArg
        }
        
        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
        func applyViewUpdates(to viewController: UpdatableVC, includeSubDepth: Bool) {
            self.viewUpdateHandlers.values.forEach { $0(viewController) }
            
            guard includeSubDepth else { return }
            self.tableView.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
            self.newMessageInfoView.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
            self.scrollBottomView.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
            self.channelStateBar.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
        }
    }
}

extension GroupChannelViewConverter.List {
    public struct TableView: ViewConverterProtocol {
        // MARK: TypeAlias
        typealias UpdatableVC = GroupChannelViewConverter.List.UpdatableVC
        
        // MARK: ViewType
        enum ViewType: ViewTypeEnum {
            case entireContent  // entire cell content
        }

        // MARK: Converter
        var entireContent: ViewConverter<ViewConfig>? {
            didSet { self.entireContent?(.init()) }
        }
        var rowView = RowView() // SBUBaseMessageCell+SwiftUI -> .entireContent
        
        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {
            public var channel: GroupChannel = DefaultViewConfigSet.groupChannel
            public var messages: [BaseMessage] = []
        }
        
        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
        func applyViewUpdates(to viewController: UpdatableVC, includeSubDepth: Bool) {
            self.viewUpdateHandlers.values.forEach { $0(viewController) }
            
            guard includeSubDepth else { return }
            
            self.rowView.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
        }
    }
    
    public struct NewMessageInfoView: ViewConverterProtocol {
        typealias UpdatableVC = GroupChannelViewConverter.List.UpdatableVC
        
        // MARK: ViewType
        enum ViewType: ViewTypeEnum {
            case entireContent
        }
        
        // MARK: Converter
        var entireContent: ViewConverter<ViewConfig>? {
            didSet { self.entireContent?(.init()) }
        }
        
        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {
            public var count: Int = 0
        }
        
        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
    }
    
    public struct ScrollBottomView: ViewConverterProtocol {
        typealias UpdatableVC = GroupChannelViewConverter.List.UpdatableVC
        
        // MARK: ViewType
        enum ViewType: ViewTypeEnum {
            case entireContent
        }
        
        // MARK: Converter
        var entireContent: ViewConverter<ViewConfig>? {
            didSet { self.entireContent?(.init()) }
        }
        
        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {
            public var buttonSize: CGSize = DefaultViewConfigSet.scrollBottomButtonSize
        }
        
        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
    }
    
    public struct ChannelStateBar: ViewConverterProtocol {
        typealias UpdatableVC = GroupChannelViewConverter.List.UpdatableVC
        
        // MARK: ViewType
        enum ViewType: ViewTypeEnum {
            case entireContent
        }
        
        // MARK: Converter
        var entireContent: ViewConverter<ViewConfig>? {
            didSet { self.entireContent?(.init()) }
        }
        
        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {
            public var height: CGFloat = DefaultViewConfigSet.Group.Channel.stateBannerHeight
        }
        
        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
        func applyViewUpdates(to viewController: UpdatableVC, includeSubDepth: Bool) {
            self.viewUpdateHandlers.values.forEach { $0(viewController) }
            
            guard includeSubDepth else { return }
        }
    }
}

extension GroupChannelViewConverter.List.TableView {
    public struct RowView: ViewConverterProtocol {
        // MARK: TypeAlias
        typealias UpdatableVC = GroupChannelViewConverter.List.UpdatableVC

        // MARK: ViewType
        enum ViewType: ViewTypeEnum {
            case entireContent  // entire cell content
            case senderProfileImage
            case adminMessage
            case userMessage
            case fileMessage
            case multipleFilesMessage
            case typingMessage
        }

        // MARK: Converter
        var entireContent: ViewConverter<ViewConfig>? {
            didSet { self.entireContent?(.init()) }
        }
        
        /// // SBUBaseMessageCell+SwiftUI -> .**
        var senderProfileImage = SenderProfileImage()
        var adminMessage = AdminMessage()
        var userMessage = UserMessage()
        var fileMessage = FileMessage()
        var multipleFilesMessage = MultipleFilesMessage()
        var typingMessage = TypingIndicator()

        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {
            public var message: BaseMessage = DefaultViewConfigSet.baseMessage
        }

        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
        func applyViewUpdates(to viewController: UpdatableVC, includeSubDepth: Bool) {
            self.viewUpdateHandlers.values.forEach { $0(viewController) }

            guard includeSubDepth else { return }
            self.senderProfileImage.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
            self.adminMessage.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
            self.userMessage.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
            self.fileMessage.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
            self.multipleFilesMessage.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
            self.typingMessage.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
        }
    }
}

extension GroupChannelViewConverter.List.TableView.RowView {
    public struct SenderProfileImage: ViewConverterProtocol {
        // MARK: ViewType
        enum ViewType: ViewTypeEnum {
            case entireContent
        }
        // MARK: Converter
        var entireContent: ViewConverter<ViewConfig>? {
            didSet { self.entireContent?(.init()) }
        }
        
        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {
            public var sender: Sender?
            public var profileURL: String = ""
            public var imageSize: CGSize = DefaultViewConfigSet.Group.Channel.senderProfileImage
        }
        
        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
    }
}

extension GroupChannelViewConverter.List.TableView.RowView {
    public struct AdminMessage: ViewConverterProtocol {
        // MARK: ViewType
        enum ViewType: ViewTypeEnum {
            case entireContent
        }
        
        // MARK: Converter
        var entireContent: ViewConverter<ViewConfig>? {
            didSet { _ = self.entireContent?(.init()) }
        }
        
        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {
            public var message: SendbirdChatSDK.AdminMessage = DefaultViewConfigSet.adminMessage
        }
        
        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
    }
    
    public struct UserMessage: ViewConverterProtocol {
        // MARK: ViewType
        enum ViewType: ViewTypeEnum {
            case entireContent
        }

        // MARK: Converter
        var entireContent: ViewConverter<ViewConfig>? {
            didSet { _ = self.entireContent?(.init()) }
        }

        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {
            public var message: SendbirdChatSDK.UserMessage = DefaultViewConfigSet.userMessage
            public var maxWidth: CGFloat = DefaultViewConfigSet.Group.Channel.textMaxWidth
        }

        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
    }
    
    public struct FileMessage: ViewConverterProtocol {
        // MARK: ViewType
        enum ViewType: ViewTypeEnum {
            case entireContent
        }
        
        // MARK: Converter
        var entireContent: ViewConverter<ViewConfig>? {
            didSet { _ = self.entireContent?(.init()) }
        }
        
        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {
            public var message: SendbirdChatSDK.FileMessage = DefaultViewConfigSet.fileMessage
            /// The size of the thumbnail image.
            public var thumbnailSize: CGSize = DefaultViewConfigSet.Group.Channel.thumbnailSize
            /// The maximum width of the non image type.
            public var maxWidth: CGFloat = DefaultViewConfigSet.Group.Channel.textMaxWidth
            /// The type of file.
            public var fileType: SBUMessageFileType = .etc
            /// The file url.
            public var fileURL: String = ""
        }
        
        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
    }
    
    public struct MultipleFilesMessage: ViewConverterProtocol {
        // MARK: ViewType
        enum ViewType: ViewTypeEnum {
            case entireContent
        }
        
        // MARK: Converter
        var entireContent: ViewConverter<ViewConfig>? {
            didSet { _ = self.entireContent?(.init()) }
        }

        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {
            public var message: SendbirdChatSDK.MultipleFilesMessage = DefaultViewConfigSet.multipleFilesMessage
            /// The size of the thumbnail image.
            public var thumbnailSize: CGSize = calculateThumbnailSize()
            /// The maximum width of the non image type.
            public var maxWidth: CGFloat = DefaultViewConfigSet.Group.Channel.thumbnailSize.width
            /// The uploaded files.
            public var files: [SendbirdChatSDK.UploadedFileInfo] = []
            /// The pending files.
            public var pendingFiles: [SendbirdChatSDK.UploadableFileInfo]?
            
            static func calculateThumbnailSize() -> CGSize {
                let bubblePadding = SBUMultipleFilesMessageCell.Constants.bubblePadding
                let itemSpacing = SBUMultipleFilesMessageCell.Constants.collectionViewItemSpacing
                let imageSize =  (SBUGlobals.messageCellConfiguration.groupChannel.thumbnailSize.width - bubblePadding * 2 - itemSpacing) / 2
                let thumbnailSize = CGSize(width: imageSize, height: imageSize)
                return thumbnailSize
            }
        }
        
        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
    }
    
    public struct TypingIndicator: ViewConverterProtocol {
        // MARK: ViewType
        enum ViewType: ViewTypeEnum {
            case entireContent
        }
        
        // MARK: Converter
        var entireContent: ViewConverter<ViewConfig>? {
            didSet { _ = self.entireContent?(.init()) }
        }
        
        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {
            public var typingInfo: SBUTypingIndicatorInfo = DefaultViewConfigSet.typingInfo
            public var maxWidth: Double = DefaultViewConfigSet.Group.Channel.textMaxWidth
            public var typingBubbleSize: CGSize = DefaultViewConfigSet.Group.Channel.typingBubbleSize
        }
        
        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
    }
}
