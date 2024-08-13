//
//  GroupChannelPushSettingsView+ViewConverter.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SendbirdChatSDK
import UIKit

// MARK: List
extension GroupChannelPushSettingsViewConverter {
    public struct List: ViewConverterProtocol {
        // MARK: TypeAlias
        public typealias ContentBaseArg = SBUGroupChannelPushSettingsModule.List
        typealias UpdatableVC = SBUGroupChannelPushSettingsViewController

        // MARK: ViewType
        enum ViewType: ViewTypeEnum {
            case entireContent  // entire tableView
        }

        // MARK: Converter
        var entireContent: ViewConverter<ViewConfig>?
        var tableView = TableView()

        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {
            public var parentView: ContentBaseArg
            // TODO: 필요하면 config 에 전달할 추가 property 구현. 필요없으면 아래 제거
            // public var groupChannel: [GroupChannel]
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

extension GroupChannelPushSettingsViewConverter.List {
    public struct TableView: ViewConverterProtocol {
        // MARK: TypeAlias
        typealias UpdatableVC = GroupChannelPushSettingsViewConverter.List.UpdatableVC
        
        // MARK: ViewType
        enum ViewType: ViewTypeEnum {
            case entireContent  // entire cell content
            // TODO: 필요하면 viewType 추가
            // case channelCell
        }

        // MARK: Converter
        var entireContent: ViewConverter<ViewConfig>?
        
        // TODO: 필요하면 하위 아이템들 추가 (↓↓ example ↓↓)
        // var channelCell = ChannelCell()
        
        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {
            
        }
        
        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
        func applyViewUpdates(to viewController: UpdatableVC, includeSubDepth: Bool) {
            self.viewUpdateHandlers.values.forEach { $0(viewController) }
            
            guard includeSubDepth else { return }
            
            // TODO: 추가로 구현한 하위 아이템들 업데이트 (↓↓ example ↓↓)
            // self.channelCell.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
        }
    }
}

// TODO: Cell 단위나 하위 아이템들은 여기 참고해서 추가 (↓↓ example ↓↓)
//extension GroupChannelPushSettingsViewConverter.List.TableView {
//    public struct ChannelCell: ViewConverterProtocol {
//        // MARK: TypeAlias
//        typealias UpdatableVC = GroupChannelPushSettingsViewConverter.List.UpdatableVC
//
//        // MARK: ViewType
//        enum ViewType: ViewTypeEnum {
//            case entireContent  // entire cell content
//            case coverImage
//        }
//
//        // MARK: Converter
//        var entireContent: ViewConverter<ViewConfig>? {
//            didSet { self.entireContent?(.init()) }
//        }
//        var coverImage = CoverImage()
//
//        // MARK: ViewConfigurations
//        public struct ViewConfig: ViewConfigurations {
//            public var groupChannel: GroupChannel = DefaultViewConfigSet.groupChannel
//        }
//
//        // MARK: View updater
//        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
//        func applyViewUpdates(to viewController: UpdatableVC, includeSubDepth: Bool) {
//            self.viewUpdateHandlers.values.forEach { $0(viewController) }
//
//            guard includeSubDepth else { return }
//            self.coverImage.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
//        }
//    }
//}
//
//extension GroupChannelPushSettingsViewConverter.List.TableView.ChannelCell {
//    public struct CoverImage: ViewConverterProtocol {
//        // MARK: ViewType
//        enum ViewType: ViewTypeEnum { case none }
//        // MARK: Converter
//        var entireContent: ViewConverter<ViewConfig>? {
//            didSet { self.entireContent?(.init()) }
//        }
//
//        // MARK: ViewConfigurations
//        public struct ViewConfig: ViewConfigurations {
//            public var groupChannel: GroupChannel = DefaultViewConfigSet.groupChannel
//            public var coverImageSize: CGFloat
//        }
//
//        // MARK: View updater
//        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
//    }
//}
