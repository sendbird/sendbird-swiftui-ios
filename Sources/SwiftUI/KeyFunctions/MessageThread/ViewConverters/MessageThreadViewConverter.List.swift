//
//  MessageThreadView+ViewConverter.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SendbirdChatSDK
import UIKit

// MARK: List
extension MessageThreadViewConverter {
    public struct List: ViewConverterProtocol {
        // MARK: TypeAlias
        public typealias ContentBaseArg = SBUMessageThreadModule.List
        typealias UpdatableVC = SBUMessageThreadViewController

        // MARK: ViewType
        enum ViewType: ViewTypeEnum {
            case entireContent  // entire tableView
        }

        // MARK: Converter
        var entireContent: ViewConverter<ViewConfig>?
        var tableView = TableView()
        var channelStateBar = ChannelStateBar() // SBUChannelStateBanner+SwiftUI

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
            self.channelStateBar.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
        }
    }
}

extension MessageThreadViewConverter.List {
    public struct TableView: ViewConverterProtocol {
        // MARK: TypeAlias
        typealias UpdatableVC = MessageThreadViewConverter.List.UpdatableVC
        
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
            public var parentMessage: BaseMessage = DefaultViewConfigSet.baseMessage
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
    
    public struct ChannelStateBar: ViewConverterProtocol {
        typealias UpdatableVC = MessageThreadViewConverter.List.UpdatableVC
        
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
            public var height: CGFloat = DefaultViewConfigSet.MessageThread.stateBannerHeight
        }
        
        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
        func applyViewUpdates(to viewController: UpdatableVC, includeSubDepth: Bool) {
            self.viewUpdateHandlers.values.forEach { $0(viewController) }
            
            guard includeSubDepth else { return }
        }
    }
}

extension MessageThreadViewConverter.List.TableView {
    public struct RowView: ViewConverterProtocol {
        // MARK: TypeAlias
        typealias UpdatableVC = MessageThreadViewConverter.List.UpdatableVC

        // MARK: ViewType
        enum ViewType: ViewTypeEnum {
            case entireContent  // entire cell content
            case senderProfileImage
            case userMessage
            case fileMessage
            case multipleFilesMessage
        }

        // MARK: Converter
        var entireContent: ViewConverter<ViewConfig>? {
            didSet { self.entireContent?(.init()) }
        }
        
        /// // SBUBaseMessageCell+SwiftUI -> .**
        var senderProfileImage = SenderProfileImage()
        var userMessage = UserMessage()
        var fileMessage = FileMessage()
        var multipleFilesMessage = MultipleFilesMessage()

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
            self.userMessage.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
            self.fileMessage.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
            self.multipleFilesMessage.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
        }
    }
}

extension MessageThreadViewConverter.List.TableView.RowView {
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

extension MessageThreadViewConverter.List.TableView.RowView {
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
}
