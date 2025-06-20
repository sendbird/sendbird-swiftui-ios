//
//  GroupChannelViewConverter.Input.swift
//  SendbirdSwiftUI
//
//  Created by Celine Moon on 7/4/24.
//

import UIKit
import SendbirdChatSDK

extension GroupChannelViewConverter {
    public struct Input: ViewConverterProtocol {
        public typealias ContentBaseArg = SBUGroupChannelModule.Input
        typealias UpdatableVC = SBUGroupChannelViewController
        
        var entireContent: ViewConverter<ViewConfig>?
        var messageInputView = MessageInputView()
        
        enum ViewType: ViewTypeEnum {
            case entireContent
        }
        
        public struct ViewConfig: ViewConfigurations {
            public var parentView: SBUGroupChannelViewController
        }
        
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
        func applyViewUpdates(to viewController: UpdatableVC, includeSubDepth: Bool) {
            self.viewUpdateHandlers.values.forEach { $0(viewController) }
            
            guard includeSubDepth else { return }
            self.messageInputView.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
        }
        
        // MARK: ViewUpdateData
        
        /// - Since: 1.1.0
        var viewUpdateData: ViewUpdateData?
        
        /// - Since: 1.1.0
        struct ViewUpdateData: ViewUpdateDataType { }
    }
}

extension GroupChannelViewConverter.Input {
    // MARK: - MessageInputView
    public struct MessageInputView: ViewConverterProtocol {
        typealias UpdatableVC = SBUGroupChannelViewController
        
        var entireContent: ViewConverter<ViewConfig>?
        var leftView = LeftView()
        var rightView = RightView()
        var topView = TopView()
        
        enum ViewType: ViewTypeEnum {
//            case entireContent  // not used.
            case leftView
            case rightView
            case topView  // 1.1.0
        }
        
        public struct ViewConfig: ViewConfigurations { }  // not used
        
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
        func applyViewUpdates(to viewController: UpdatableVC, includeSubDepth: Bool) {
            self.viewUpdateHandlers.values.forEach { $0(viewController) }
            
            guard includeSubDepth else { return }
            self.leftView.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
            self.rightView.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
            self.topView.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
        }
        
        // MARK: ViewUpdateData
        
        /// - Since: 1.1.0
        var viewUpdateData: ViewUpdateData?
        
        /// - Since: 1.1.0
        struct ViewUpdateData: ViewUpdateDataType { }
    }
}

extension GroupChannelViewConverter.Input.MessageInputView {
    // MARK: - LeftView
    public struct LeftView: ViewConverterProtocol {
        typealias UpdatableVC = SBUGroupChannelViewController
        
        var entireContent: ViewConverter<ViewConfig>?
        var addButton = AddButton()
        
        enum ViewType: ViewTypeEnum {
            case entireContent  // use `MessageInputView.leftView` instead
            case addButton
        }
        
        public struct ViewConfig: ViewConfigurations {
            public var buttonSize: CGSize = DefaultViewConfigSet.GroupChannel.Input.buttonSize
            public var isFrozen: Bool = false
            public var isMuted: Bool = false
        }
        
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
        
        func applyViewUpdates(to viewController: UpdatableVC, includeSubDepth: Bool) {
            self.viewUpdateHandlers.values.forEach { $0(viewController) }
            
            guard includeSubDepth else { return }
            self.addButton.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
        }
        
        // MARK: ViewUpdateData
        
        /// - Since: 1.1.0
        var viewUpdateData: ViewUpdateData?
        
        /// - Since: 1.1.0
        struct ViewUpdateData: ViewUpdateDataType { }
    }
    
    // MARK: - RightView
    public struct RightView: ViewConverterProtocol {
        typealias UpdatableVC = SBUGroupChannelViewController
        
        var entireContent: ViewConverter<ViewConfig>?
        var sendButton = SendButton()
        var voiceButton = VoiceButton()
        
        enum ViewType: ViewTypeEnum {
            case entireContent  // use `MessageInputView.leftView` instead
            case sendButton
            case voiceButton
        }
        
        public struct ViewConfig: ViewConfigurations {
            public var buttonSize: CGSize = DefaultViewConfigSet.GroupChannel.Input.buttonSize
            public var isFrozen: Bool = false
            public var isMuted: Bool = false
        }
        
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
        
        func applyViewUpdates(to viewController: UpdatableVC, includeSubDepth: Bool) {
            self.viewUpdateHandlers.values.forEach { $0(viewController) }
            
            guard includeSubDepth else { return }
            self.sendButton.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
            self.voiceButton.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
        }
        
        // MARK: ViewUpdateData
        
        /// - Since: 1.1.0
        var viewUpdateData: ViewUpdateData?
        
        /// - Since: 1.1.0
        struct ViewUpdateData: ViewUpdateDataType { }
    }
    
    /// - Since: 1.1.0
    public struct TopView: ViewConverterProtocol {
        typealias UpdatableVC = SBUGroupChannelViewController
        
        var entireContent: ViewConverter<ViewConfig>?
        
        enum ViewType: ViewTypeEnum {
            case entireContent
        }
        
        public struct ViewConfig: ViewConfigurations {
            public var isFrozen: Bool = false
            public var isMuted: Bool = false
            public var isQuoteReplyingMode: Bool = false
            public var quoteMessageInputViewConfiguration: QuoteMessageInputView.Configuration
            public var quoteMessageInputViewHeight: CGFloat
        }
        
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
            
        func applyViewUpdates(to viewController: UpdatableVC, includeSubDepth: Bool) {
            self.viewUpdateHandlers.values.forEach { $0(viewController) }
            
            // call applyViewUpdates on sub items
            // guard includeSubDepth else { return }
            // self.sendButton.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
        }
        
        // MARK: ViewUpdateData
        
        /// - Since: 1.1.0
        var viewUpdateData: ViewUpdateData?
        
        /// - Since: 1.1.0
        struct ViewUpdateData: ViewUpdateDataType {
            var isHidden: Bool?
            var isEnabled: Bool?
            var alpha: CGFloat?
            var quoteMessageInputViewParams: SBUQuoteMessageInputViewParams?
        }
    }
}

extension GroupChannelViewConverter.Input.MessageInputView.LeftView {
    // MARK: - AddButton
    public struct AddButton: ViewConverterProtocol {
        typealias UpdatableVC = SBUGroupChannelViewController
        
        var entireContent: ViewConverter<ViewConfig>?
        
        enum ViewType: ViewTypeEnum {
            case entireContent
        }
        
        public struct ViewConfig: ViewConfigurations {
            public var buttonSize: CGSize = DefaultViewConfigSet.GroupChannel.Input.buttonSize
            public var isFrozen: Bool = false
            public var isMuted: Bool = false
        }
        
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
        
        // MARK: ViewUpdateData
        
        /// - Since: 1.1.0
        var viewUpdateData: ViewUpdateData?
        
        /// - Since: 1.1.0
        struct ViewUpdateData: ViewUpdateDataType { }
    }
}

extension GroupChannelViewConverter.Input.MessageInputView.RightView {
    // MARK: - Send button
    public struct SendButton: ViewConverterProtocol {
        typealias UpdatableVC = SBUGroupChannelViewController
        
        var entireContent: ViewConverter<ViewConfig>?
        
        enum ViewType: ViewTypeEnum {
            case entireContent
        }
        
        public struct ViewConfig: ViewConfigurations {
            public var buttonSize: CGSize = DefaultViewConfigSet.GroupChannel.Input.buttonSize
            public var isFrozen: Bool = false
            public var isMuted: Bool = false
        }
        
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
        
        // MARK: ViewUpdateData
        
        /// - Since: 1.1.0
        var viewUpdateData: ViewUpdateData?
        
        /// - Since: 1.1.0
        struct ViewUpdateData: ViewUpdateDataType { }
    }
    
    // MARK: - Voice message button
    public struct VoiceButton: ViewConverterProtocol {
        typealias UpdatableVC = SBUGroupChannelViewController
        
        var entireContent: ViewConverter<ViewConfig>?
        
        enum ViewType: ViewTypeEnum {
            case entireContent
        }
        
        public struct ViewConfig: ViewConfigurations {
            public var buttonSize: CGSize = DefaultViewConfigSet.GroupChannel.Input.buttonSize
            public var isFrozen: Bool = false
            public var isMuted: Bool = false
        }
        
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
        
        // MARK: ViewUpdateData
        
        /// - Since: 1.1.0
        var viewUpdateData: ViewUpdateData?
        
        /// - Since: 1.1.0
        struct ViewUpdateData: ViewUpdateDataType { }
    }
}
