//
//  SBUMessageThreadModule.ParentInfo+SwiftUI.swift
//  SendbirdUIKit
//
//  Created by Damon Park on 7/7/24.
//

import SendbirdChatSDK
import UIKit

// MARK: List
extension MessageThreadViewConverter {
    public struct ParentInfo: ViewConverterProtocol {
        // MARK: TypeAlias
        public typealias ContentBaseArg = SBUMessageThreadModule.List
        typealias UpdatableVC = SBUMessageThreadViewController

        // MARK: ViewType
        enum ViewType: ViewTypeEnum {
            case entireContent  // entire parent info view
            
            case profileView
            case userNameLabel
            case dateLabel
            case moreButton
            case replyLabel
            case messageTextView
            case fileContentView
            case multipleFileContentView
            case webView
            case reactionView
        }

        // MARK: Converter
        var entireContent: ViewConverter<ViewConfig>? {
            didSet { self.entireContent?(.init()) }
        }
        
        var profileView = ProfileView()
        var userNameLabel = UserNameLabel()
        var dateLabel = DateLabel()
        var moreButton = MoreButton()
        var replyLabel = ReplyLabel()
        var messageTextView = MessageTextView()
        var fileContentView = FileContentView()
        var multipleFileContentView = MultipleFileContentView()
        var webView = WebView()
        var reactionView = ReactionView()
        
        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {
            public var parentMessage: BaseMessage = DefaultViewConfigSet.baseMessage
        }
        
        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
        func applyViewUpdates(to viewController: UpdatableVC, includeSubDepth: Bool) {
            self.viewUpdateHandlers.values.forEach { $0(viewController) }
            
            guard includeSubDepth else { return }
            
            self.profileView.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
            self.userNameLabel.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
            self.dateLabel.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
            self.moreButton.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
            self.replyLabel.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
            self.messageTextView.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
            self.fileContentView.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
            self.multipleFileContentView.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
            self.webView.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
            self.reactionView.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
        }
    }
}

extension MessageThreadViewConverter.ParentInfo {
    public struct ProfileView: ViewConverterProtocol {
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
        
        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {
            public var parentView: SBUParentMessageInfoView = SBUParentMessageInfoView()
            public var parentMessage: BaseMessage = DefaultViewConfigSet.baseMessage
        }
        
        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
    }
    
    public struct UserNameLabel: ViewConverterProtocol {
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
        
        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {
            public var parentView: SBUParentMessageInfoView = SBUParentMessageInfoView()
            public var parentMessage: BaseMessage = DefaultViewConfigSet.baseMessage
        }
        
        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
    }
    
    public struct DateLabel: ViewConverterProtocol {
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
        
        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {
            public var parentView: SBUParentMessageInfoView = SBUParentMessageInfoView()
            public var parentMessage: BaseMessage = DefaultViewConfigSet.baseMessage
        }
        
        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
    }
    
    public struct MoreButton: ViewConverterProtocol {
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
        
        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {
            public var parentView: SBUParentMessageInfoView = SBUParentMessageInfoView()
            public var parentMessage: BaseMessage = DefaultViewConfigSet.baseMessage
        }
        
        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
    }
    
    public struct ReplyLabel: ViewConverterProtocol {
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
        
        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {
            public var parentView: SBUParentMessageInfoView = SBUParentMessageInfoView()
            public var parentMessage: BaseMessage = DefaultViewConfigSet.baseMessage
        }
        
        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
    }
    
    public struct MessageTextView: ViewConverterProtocol {
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
        
        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {
            public var parentView: SBUParentMessageInfoView = SBUParentMessageInfoView()
            public var parentMessage: BaseMessage = DefaultViewConfigSet.baseMessage
            /// The maximum width of the non image type.
            public var maxWidth: CGFloat = DefaultViewConfigSet.Group.Channel.textMaxWidth
        }
        
        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
    }
    
    // voice / image & video / file / multiplefile
    public struct FileContentView: ViewConverterProtocol {
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
        
        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {
            public var parentView: SBUParentMessageInfoView = SBUParentMessageInfoView()
            public var fileMessage: FileMessage = DefaultViewConfigSet.fileMessage
            /// The size of the thumbnail image.
            public var thumbnailSize: CGSize = DefaultViewConfigSet.Group.Channel.thumbnailSize
            /// The maximum width of the non image type.
            public var maxWidth: CGFloat = DefaultViewConfigSet.Group.Channel.textMaxWidth
        }
        
        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
    }
    
    public struct MultipleFileContentView: ViewConverterProtocol {
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
        
        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {
            public var parentView: SBUParentMessageInfoView = SBUParentMessageInfoView()
            public var multipleFilesMessage: MultipleFilesMessage = DefaultViewConfigSet.multipleFilesMessage
            /// The size of the thumbnail image.
            public var thumbnailSize: CGSize = DefaultViewConfigSet.Group.Thread.ParentInfoView.multipleFilesThumbnailSize
            /// The maximum width of the non image type.
            public var maxWidth: CGFloat = DefaultViewConfigSet.Group.Channel.textMaxWidth
        }
        
        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
    }
    
    public struct WebView: ViewConverterProtocol {
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
        
        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {
            public var parentView: SBUParentMessageInfoView = SBUParentMessageInfoView()
            public var parentMessage: BaseMessage = DefaultViewConfigSet.baseMessage
            public var ogMetaData: SendbirdChatSDK.OGMetaData = DefaultViewConfigSet.ogMetaData
        }
        
        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
    }
    
    public struct ReactionView: ViewConverterProtocol {
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
        
        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {
            public var parentView: SBUParentMessageInfoView = SBUParentMessageInfoView()
            public var parentMessage: BaseMessage = DefaultViewConfigSet.baseMessage
        }
        
        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
    }
}
