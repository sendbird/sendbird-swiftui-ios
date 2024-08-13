//
//  OpenChannelView+ViewConverter.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SendbirdChatSDK
import UIKit

// MARK: List
extension OpenChannelViewConverter {
    public struct List: ViewConverterProtocol {
        // MARK: TypeAlias
        public typealias ContentBaseArg = SBUOpenChannelModule.List
        typealias UpdatableVC = SBUOpenChannelViewController

        // MARK: ViewType
        enum ViewType: ViewTypeEnum {
            case none  // entire tableView
        }

        // MARK: Converter
        /// Never used. Use `TableView.entireContent` instead.
        var entireContent: ViewConverter<ViewConfig>?
        var tableView = TableView()
        var scrollBottomView = ScrollBottomView()

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
            self.scrollBottomView.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
        }
    }
}

extension OpenChannelViewConverter.List {
    public struct TableView: ViewConverterProtocol {
        // MARK: TypeAlias
        typealias UpdatableVC = OpenChannelViewConverter.List.UpdatableVC
        
        // MARK: ViewType
        enum ViewType: ViewTypeEnum {
            case entireContent  // entire cell content
        }

        // MARK: Converter
        var entireContent: ViewConverter<ViewConfig>? {
            didSet { self.entireContent?(.init()) }
        }
        var rowView = RowView() // messageCell
        
        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {
            public var channel: OpenChannel = DefaultViewConfigSet.openChannel
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
    
    public struct ScrollBottomView: ViewConverterProtocol {
        typealias UpdatableVC = OpenChannelViewConverter.List.UpdatableVC
        
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
}

extension OpenChannelViewConverter.List.TableView {
    public struct RowView: ViewConverterProtocol {
        // MARK: TypeAlias
        typealias UpdatableVC = OpenChannelViewConverter.List.UpdatableVC

        // MARK: ViewType
        enum ViewType: ViewTypeEnum {
            case entireContent  // entire cell content
            case senderProfileImage
            case adminMessage
            case userMessage
            case fileMessage
        }

        // MARK: Converter
        var entireContent: ViewConverter<ViewConfig>? {
            didSet { self.entireContent?(.init()) }
        }
        var senderProfileImage = SenderProfileImage()
        var adminMessage = AdminMessage()
        var userMessage = UserMessage()
        var fileMessage = FileMessage()

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
        }
    }
}

extension OpenChannelViewConverter.List.TableView.RowView {
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
            public var imageSize: CGSize = DefaultViewConfigSet.Open.Channel.senderProfileImage
        }

        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
    }
}

extension OpenChannelViewConverter.List.TableView.RowView {
    public struct AdminMessage: ViewConverterProtocol {
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
            didSet { self.entireContent?(.init()) }
        }

        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {
            public var message: SendbirdChatSDK.UserMessage = DefaultViewConfigSet.userMessage
            public var maxWidth: CGFloat = DefaultViewConfigSet.Open.Channel.textMaxWidth
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
            public var thumbnailSize: CGSize = DefaultViewConfigSet.Open.Channel.thumbnailSize
            /// The maximum width of the non image type.
            public var maxWidth: CGFloat = DefaultViewConfigSet.Open.Channel.textMaxWidth
            /// The type of file.
            public var fileType: SBUMessageFileType = .etc
            /// The file url.
            public var fileURL: String = ""
        }

        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
    }
}
