//
//  GroupChannelListView+ViewConverter.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SendbirdChatSDK

// MARK: - Header
extension GroupChannelListViewConverter {
    public struct Header: ViewConverterProtocol {
        // MARK: TypeAlias
        public typealias ContentBaseArg = SBUGroupChannelListModule.Header
        typealias UpdatableVC = SBUGroupChannelListViewController
        
        // MARK: ViewType
        enum ViewType: ViewTypeEnum {
            case leftView
            case rightView
            case titleView
        }

        // MARK: Converter
        // NOTE: no interface for replacing the entire Header.
        var entireContent: ViewConverter<ViewConfig>?
        var leftView = LeftView()
        var rightView = RightView()
        var titleView = TitleView()
        
        // MARK: ViewConfigurations
        /// The configuration for the Header.
        public struct ViewConfig: ViewConfigurations {
            var parentView: ContentBaseArg
            var channels: [GroupChannel]
        }

        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
        func applyViewUpdates(to viewController: UpdatableVC, includeSubDepth: Bool) {
            self.viewUpdateHandlers.values.forEach { $0(viewController) }
            
            guard includeSubDepth else { return }
            self.leftView.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
            self.rightView.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
            self.titleView.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
        }
    }
}

extension GroupChannelListViewConverter.Header {
    /// A converter that updates the left bar button of a `SBUGroupChannelListViewController`.
    public struct LeftView: ViewConverterProtocol {
        // MARK: ViewType
        enum ViewType: ViewTypeEnum { case none }
        // MARK: Converter
        var entireContent: ViewConverter<ViewConfig>?
        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {
            public var parentView: ContentBaseArg
        }
        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
    }
    
    /// A converter that updates the right bar button of a `SBUGroupChannelListViewController`.
    public struct RightView: ViewConverterProtocol {
        // MARK: ViewType
        enum ViewType: ViewTypeEnum { case none }
        // MARK: Converter
        var entireContent: ViewConverter<ViewConfig>?
        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {
            public var parentView: ContentBaseArg
        }
        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
    }
    
    /// A converter that updates the title view of a `SBUGroupChannelListViewController`.
    public struct TitleView: ViewConverterProtocol {
        // MARK: ViewType
        enum ViewType: ViewTypeEnum { case none }
        // MARK: Converter
        var entireContent: ViewConverter<ViewConfig>?
        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {
            public var parentView: ContentBaseArg
        }
        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
    }
}