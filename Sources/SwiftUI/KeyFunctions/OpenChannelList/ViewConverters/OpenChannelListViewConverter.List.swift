//
//  OpenChannelListView+ViewConverter.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SendbirdChatSDK
import UIKit

// MARK: List
extension OpenChannelListViewConverter {
    public struct List: ViewConverterProtocol {
        // MARK: TypeAlias
        public typealias ContentBaseArg = SBUOpenChannelListModule.List
        typealias UpdatableVC = SBUOpenChannelListViewController
        
        // MARK: ViewType
        enum ViewType: ViewTypeEnum {
            case entireContent
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

extension OpenChannelListViewConverter.List {
    public struct TableView: ViewConverterProtocol {
        // MARK: TypeAlias
        typealias UpdatableVC = OpenChannelListViewConverter.List.UpdatableVC
        
        // MARK: ViewType
        enum ViewType: ViewTypeEnum {
            case entireContent  // entire tableView
        }
        
        // MARK: Converter
        var entireContent: ViewConverter<ViewConfig>?
        
        var channelCell = ChannelCell()
        
        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {
            public var channels: [OpenChannel]
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

extension OpenChannelListViewConverter.List.TableView {
    public struct ChannelCell: ViewConverterProtocol {
        // MARK: TypeAlias
        typealias UpdatableVC = OpenChannelListViewConverter.List.UpdatableVC
        
        // MARK: ViewType
        enum ViewType: ViewTypeEnum {
            case entireContent  // entire cell content
            case coverImage
            case channelName
            case channelPreview
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
        
        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {
            public var channel: OpenChannel = DefaultViewConfigSet.openChannel
        }
        
        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
        func applyViewUpdates(to viewController: UpdatableVC, includeSubDepth: Bool) {
            self.viewUpdateHandlers.values.forEach { $0(viewController) }
            
            guard includeSubDepth else { return }
            self.coverImage.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
            self.channelName.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
            self.channelPreview.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
        }
    }
}

extension OpenChannelListViewConverter.List.TableView.ChannelCell {
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
            public var channel: OpenChannel = DefaultViewConfigSet.openChannel
            public var imageSize: CGSize = DefaultViewConfigSet.OpenChannelList.coverImageSize
            public var coverURL: String?
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
            public var channel: OpenChannel = DefaultViewConfigSet.openChannel
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
            public var channel: OpenChannel = DefaultViewConfigSet.openChannel
            public var previewMessage: String = ""
        }
        
        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
    }
}
