//
//  OpenChannelViewConverter.Input.swift
//  SendbirdSwiftUI
//
//  Created by Tez Park on 7/8/24.
//

import UIKit
import SendbirdChatSDK

extension OpenChannelViewConverter {
    public struct Input: ViewConverterProtocol {
        public typealias ContentBaseArg = SBUOpenChannelModule.Input
        typealias UpdatableVC = SBUOpenChannelViewController
        
        var entireContent: ViewConverter<ViewConfig>?
        var messageInputView = MessageInputView()
        
        enum ViewType: ViewTypeEnum {
            case entireContent
        }
        
        public struct ViewConfig: ViewConfigurations {
            public var parentView: SBUOpenChannelViewController
        }
        
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
        
        func applyViewUpdates(to viewController: UpdatableVC, includeSubDepth: Bool) {
            self.viewUpdateHandlers.values.forEach { $0(viewController) }
            
            guard includeSubDepth else { return }
            self.messageInputView.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
        }
    }
}

extension OpenChannelViewConverter.Input {
    // MARK: - MessageInputView
    public struct MessageInputView: ViewConverterProtocol {
        typealias UpdatableVC = SBUOpenChannelViewController
        
        var entireContent: ViewConverter<ViewConfig>?
        var leftView = LeftView()
        var rightView = RightView()
        
        enum ViewType: ViewTypeEnum {
//            case entireContent  // not used.
            case leftView
            case rightView
        }
        
        public struct ViewConfig: ViewConfigurations { }  // not used
        
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
        func applyViewUpdates(to viewController: UpdatableVC, includeSubDepth: Bool) {
            self.viewUpdateHandlers.values.forEach { $0(viewController) }
            
            guard includeSubDepth else { return }
            self.leftView.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
            self.rightView.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
        }
    }
}

extension OpenChannelViewConverter.Input.MessageInputView {
    // MARK: - LeftView
    public struct LeftView: ViewConverterProtocol {
        typealias UpdatableVC = SBUOpenChannelViewController
        
        var entireContent: ViewConverter<ViewConfig>?
        var addButton = AddButton()
        
        enum ViewType: ViewTypeEnum {
            case entireContent  // use `MessageInputView.leftView` instead
            case addButton
        }
        
        public struct ViewConfig: ViewConfigurations {
            public var buttonSize: CGSize = DefaultViewConfigSet.OpenChannel.Input.buttonSize
            public var isFrozen: Bool = false
            public var isMuted: Bool = false
        }
        
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
        
        func applyViewUpdates(to viewController: UpdatableVC, includeSubDepth: Bool) {
            self.viewUpdateHandlers.values.forEach { $0(viewController) }
            
            guard includeSubDepth else { return }
            self.addButton.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
        }
    }
    
    // MARK: - RightView
    public struct RightView: ViewConverterProtocol {
        typealias UpdatableVC = SBUOpenChannelViewController
        
        var entireContent: ViewConverter<ViewConfig>?
        var sendButton = SendButton()
        
        enum ViewType: ViewTypeEnum {
            case entireContent  // use `MessageInputView.leftView` instead
            case sendButton
        }
        
        public struct ViewConfig: ViewConfigurations {
            public var buttonSize: CGSize = DefaultViewConfigSet.OpenChannel.Input.buttonSize
            public var isFrozen: Bool = false
            public var isMuted: Bool = false
        }
        
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
        
        func applyViewUpdates(to viewController: UpdatableVC, includeSubDepth: Bool) {
            self.viewUpdateHandlers.values.forEach { $0(viewController) }
            
            guard includeSubDepth else { return }
            self.sendButton.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
        }
    }
}

extension OpenChannelViewConverter.Input.MessageInputView.LeftView {
    // MARK: - AddButton
    public struct AddButton: ViewConverterProtocol {
        typealias UpdatableVC = SBUOpenChannelViewController
        
        var entireContent: ViewConverter<ViewConfig>?
        
        enum ViewType: ViewTypeEnum {
            case entireContent
        }
        
        public struct ViewConfig: ViewConfigurations {
            public var buttonSize: CGSize = DefaultViewConfigSet.OpenChannel.Input.buttonSize
            public var isFrozen: Bool = false
            public var isMuted: Bool = false
        }
        
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
    }
}

extension OpenChannelViewConverter.Input.MessageInputView.RightView {
    // MARK: - Send button
    public struct SendButton: ViewConverterProtocol {
        typealias UpdatableVC = SBUOpenChannelViewController
        
        var entireContent: ViewConverter<ViewConfig>?
        
        enum ViewType: ViewTypeEnum {
            case entireContent
        }
        
        public struct ViewConfig: ViewConfigurations {
            public var buttonSize: CGSize = DefaultViewConfigSet.OpenChannel.Input.buttonSize
            public var isFrozen: Bool = false
            public var isMuted: Bool = false
        }
        
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
    }
}
