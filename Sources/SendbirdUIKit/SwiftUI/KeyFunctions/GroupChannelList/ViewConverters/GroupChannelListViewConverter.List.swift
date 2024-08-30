//
//  GroupChannelListView+ViewConverter.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SendbirdChatSDK
import UIKit

// MARK: List
extension GroupChannelListViewConverter {
    public struct List: ViewConverterProtocol {
        // MARK: TypeAlias
        public typealias ContentBaseArg = SBUGroupChannelListModule.List
        typealias UpdatableVC = SBUGroupChannelListViewController

        // MARK: ViewType
        enum ViewType: ViewTypeEnum {
            case entireContent  // entire tableView
        }

        // MARK: Converter
        var entireContent: ViewConverter<ViewConfig>? // <- will never be used
        var tableView = TableView()

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
        }
    }
}

extension GroupChannelListViewConverter.List {
    public struct TableView: ViewConverterProtocol {
        // MARK: TypeAlias
        typealias UpdatableVC = GroupChannelListViewConverter.List.UpdatableVC
        
        // MARK: ViewType
        enum ViewType: ViewTypeEnum {
            case entireContent  // entire cell content
        }

        // MARK: Converter
        var entireContent: ViewConverter<ViewConfig>?
        var channelCell = ChannelCell()
        
        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {
            public var channels: [GroupChannel]
        }
        
        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
        func applyViewUpdates(to viewController: UpdatableVC, includeSubDepth: Bool) {
            self.viewUpdateHandlers.values.forEach { $0(viewController) }
            
            guard includeSubDepth else { return }
            self.channelCell.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
        }
    }
}

extension GroupChannelListViewConverter.List.TableView {
    public struct ChannelCell: ViewConverterProtocol {
        // MARK: TypeAlias
        typealias UpdatableVC = GroupChannelListViewConverter.List.UpdatableVC
        
        // MARK: ViewType
        enum ViewType: ViewTypeEnum {
            case entireContent  // entire cell content
            case coverImage
            case channelName
            case channelPreview
            case unreadCount
        }

        // MARK: Converter
        var entireContent: ViewConverter<ViewConfig>? {
            didSet {
                _ = entireContent?(.init())
            }
        }
        var coverImage = CoverImage()
        var channelName = ChannelName()
        var channelPreview = ChannelPreview()
        var unreadCount = UnreadCount()
        
        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {
            public var channel: GroupChannel = DefaultViewConfigSet.groupChannel
        }
        
        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
        func applyViewUpdates(to viewController: UpdatableVC, includeSubDepth: Bool) {
            self.viewUpdateHandlers.values.forEach { $0(viewController) }
            
            guard includeSubDepth else { return }
            self.coverImage.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
            self.channelName.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
            self.channelPreview.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
            self.unreadCount.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
        }
    }
}

extension GroupChannelListViewConverter.List.TableView.ChannelCell {
    public struct CoverImage: ViewConverterProtocol {
        // MARK: ViewType
        enum ViewType: ViewTypeEnum { case none }
        // MARK: Converter
        var entireContent: ViewConverter<ViewConfig>? {
            didSet {
                _ = entireContent?(.init())
            }
        }
        
        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {
            public var channel: GroupChannel = DefaultViewConfigSet.groupChannel
            public var imageSize: CGSize = DefaultViewConfigSet.GroupChannelList.coverImageSize
            public var coverURL: String? = nil
            public var isBroadcastChannel: Bool = false
        }
        
        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
    }
    
    public struct ChannelName: ViewConverterProtocol {
        // MARK: ViewType
        enum ViewType: ViewTypeEnum { case none }
        // MARK: Converter
        var entireContent: ViewConverter<ViewConfig>? {
            didSet {
                _ = entireContent?(.init())
            }
        }
        
        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {
            public var channel: GroupChannel = DefaultViewConfigSet.groupChannel
            public var channelName: String = ""
        }
        
        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
    }
    
    public struct ChannelPreview: ViewConverterProtocol {
        // MARK: ViewType
        enum ViewType: ViewTypeEnum { case none }
        // MARK: Converter
        var entireContent: ViewConverter<ViewConfig>? {
            didSet {
                _ = entireContent?(.init())
            }
        }
        
        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {
            public var channel: GroupChannel = DefaultViewConfigSet.groupChannel
            public var previewMessage: String = ""
        }
        
        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
    }
    
    public struct UnreadCount: ViewConverterProtocol {
        // MARK: ViewType
        enum ViewType: ViewTypeEnum { case none }
        // MARK: Converter
        var entireContent: ViewConverter<ViewConfig>? {
            didSet {
                _ = entireContent?(.init())
            }
        }
        
        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {
            public var channel: GroupChannel = DefaultViewConfigSet.groupChannel
            public var badgeHeight: CGFloat = DefaultViewConfigSet.GroupChannelList.badgeHeight
            public var unreadCount: UInt = 0
        }
        
        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
    }
}
