//
//  GroupChannelSettingsView+ViewConverter.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SendbirdChatSDK
import UIKit

// MARK: List
extension GroupChannelSettingsViewConverter {
    public struct List: ViewConverterProtocol {
        // MARK: TypeAlias
        public typealias ContentBaseArg = SBUGroupChannelSettingsModule.List
        typealias UpdatableVC = SBUGroupChannelSettingsViewController

        // MARK: ViewType
        enum ViewType: ViewTypeEnum {
            case entireContent // Won't be used
        }

        // MARK: Converter
        var entireContent: ViewConverter<ViewConfig>?
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

extension GroupChannelSettingsViewConverter.List {
    public struct TableView: ViewConverterProtocol {
        // MARK: TypeAlias
        typealias UpdatableVC = GroupChannelSettingsViewConverter.List.UpdatableVC
        
        // MARK: ViewType
        enum ViewType: ViewTypeEnum {
            case entireContent  // entire tableView content
            case channelInfo // tableView's header
        }

        // MARK: Converter
        var entireContent: ViewConverter<ViewConfig>? {
            didSet { _ = self.entireContent?(.init()) }
        }
        var channelInfo = ChannelInfo() // tableView's header in UIKit
        var settingCell = SettingCell()

        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {
            public var parentView: ContentBaseArg = .init()
            public var channel: GroupChannel = DefaultViewConfigSet.groupChannel
        }
        
        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
        func applyViewUpdates(to viewController: UpdatableVC, includeSubDepth: Bool) {
            self.viewUpdateHandlers.values.forEach { $0(viewController) }
            
            guard includeSubDepth else { return }
            
            self.channelInfo.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
            self.settingCell.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
        }
    }
}

extension GroupChannelSettingsViewConverter.List.TableView {
    public struct SettingCell: ViewConverterProtocol {
        // MARK: TypeAlias
        typealias UpdatableVC = GroupChannelSettingsViewConverter.List.UpdatableVC

        // MARK: ViewType
        enum ViewType: ViewTypeEnum {
            case entireContent // Won't be use. Cannot apply same view builder for all other view types
            case moderation
            case notification
            case member
            case searchItem
            case leaveChannel
        }
        
        // MARK: Converter
        // Won't be use. Cannot apply same view builder for all other view types
        var entireContent: ViewConverter<ViewConfig>? {
            didSet { _ = self.entireContent?(.init()) }
        }
        // Each cell
        var moderation = Moderation()
        var notification = Notification()
        var member = Member()
        var searchItem = SearchItem()
        var leaveChannel = LeaveChannel()

        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {}

        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
        func applyViewUpdates(to viewController: UpdatableVC, includeSubDepth: Bool) {
            self.viewUpdateHandlers.values.forEach { $0(viewController) }

            guard includeSubDepth else { return }
            self.moderation.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
            self.notification.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
            self.member.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
            self.searchItem.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
            self.leaveChannel.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
        }
    }
    
    public struct ChannelInfo: ViewConverterProtocol {
        // MARK: TypeAlias
       typealias UpdatableVC = GroupChannelSettingsViewConverter.List.TableView.UpdatableVC

       // MARK: ViewType
       enum ViewType: ViewTypeEnum {
           case entireContent  // entire tableView
       }

       // MARK: Converter
       var entireContent: ViewConverter<ViewConfig>? {
           didSet { _ = self.entireContent?(.init()) }
       }

       // MARK: ViewConfigurations
       public struct ViewConfig: ViewConfigurations {
           public var channel: GroupChannel = DefaultViewConfigSet.groupChannel
       }
       
       // MARK: View updater
       var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
       func applyViewUpdates(to viewController: UpdatableVC, includeSubDepth: Bool) {
           self.viewUpdateHandlers.values.forEach { $0(viewController) }
           
           guard includeSubDepth else { return }
       }
    }
}

extension GroupChannelSettingsViewConverter.List.TableView.SettingCell {
    public struct Moderation: ViewConverterProtocol {
         // MARK: TypeAlias
        typealias UpdatableVC = GroupChannelSettingsViewConverter.List.TableView.UpdatableVC

        // MARK: ViewType
        enum ViewType: ViewTypeEnum {
            case entireContent  // entire tableView
        }

        // MARK: Converter
        var entireContent: ViewConverter<ViewConfig>? {
            didSet { _ = self.entireContent?(.init()) }
        }

        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {
            public var title: String = ""
            public var rowHeight: CGFloat = DefaultViewConfigSet.groupSettingsRowHeight
//            public var tapHandler: (() -> Void)?
        }
        
        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
        func applyViewUpdates(to viewController: UpdatableVC, includeSubDepth: Bool) {
            self.viewUpdateHandlers.values.forEach { $0(viewController) }
            
            guard includeSubDepth else { return }
        }        
    }
        
    public struct Notification: ViewConverterProtocol {
         // MARK: TypeAlias
        typealias UpdatableVC = GroupChannelSettingsViewConverter.List.TableView.UpdatableVC

        // MARK: ViewType
        enum ViewType: ViewTypeEnum {
            case entireContent  // entire tableView
        }

        // MARK: Converter
        var entireContent: ViewConverter<ViewConfig>? {
            didSet { _ = self.entireContent?(.init()) }
        }

        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {
            public var title: String = ""
            public var pushTriggerOption: SendbirdChatSDK.GroupChannelPushTriggerOption = DefaultViewConfigSet.groupChannelPushTriggerOption
            public var rowHeight: CGFloat = DefaultViewConfigSet.groupSettingsRowHeight
//            public var tapHandler: (() -> Void)?  // Currently not used
        }
        
        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
        func applyViewUpdates(to viewController: UpdatableVC, includeSubDepth: Bool) {
            self.viewUpdateHandlers.values.forEach { $0(viewController) }
            
            guard includeSubDepth else { return }
        }        
    }

    public struct Member: ViewConverterProtocol {
         // MARK: TypeAlias
        typealias UpdatableVC = GroupChannelSettingsViewConverter.List.TableView.UpdatableVC

        // MARK: ViewType
        enum ViewType: ViewTypeEnum {
            case entireContent  // entire tableView
        }

        // MARK: Converter
        var entireContent: ViewConverter<ViewConfig>? {
            didSet { _ = self.entireContent?(.init()) }
        }

        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {
            public var title: String = ""
            public var memberCount: Int = 0
            public var rowHeight: CGFloat = DefaultViewConfigSet.groupSettingsRowHeight
//            public var tapHandler: (() -> Void)?  // Currently not used
        }
        
        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
        func applyViewUpdates(to viewController: UpdatableVC, includeSubDepth: Bool) {
            self.viewUpdateHandlers.values.forEach { $0(viewController) }
            
            guard includeSubDepth else { return }
        }        
    }

    public struct SearchItem: ViewConverterProtocol {
         // MARK: TypeAlias
        typealias UpdatableVC = GroupChannelSettingsViewConverter.List.TableView.UpdatableVC

        // MARK: ViewType
        enum ViewType: ViewTypeEnum {
            case entireContent  // entire tableView
        }

        // MARK: Converter
        var entireContent: ViewConverter<ViewConfig>? {
            didSet { _ = self.entireContent?(.init()) }
        }

        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {
            public var title: String = ""
            public var rowHeight: CGFloat = DefaultViewConfigSet.groupSettingsRowHeight
//            public var tapHandler: (() -> Void)?
        }
        
        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
        func applyViewUpdates(to viewController: UpdatableVC, includeSubDepth: Bool) {
            self.viewUpdateHandlers.values.forEach { $0(viewController) }
            
            guard includeSubDepth else { return }
        }        
    }

    public struct LeaveChannel: ViewConverterProtocol {
         // MARK: TypeAlias
        typealias UpdatableVC = GroupChannelSettingsViewConverter.List.TableView.UpdatableVC

        // MARK: ViewType
        enum ViewType: ViewTypeEnum {
            case entireContent  // entire tableView
        }

        // MARK: Converter
        var entireContent: ViewConverter<ViewConfig>? {
            didSet { _ = self.entireContent?(.init()) }
        }

        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {
            public var title: String = ""
            public var rowHeight: CGFloat = DefaultViewConfigSet.groupSettingsRowHeight
//            public var tapHandler: (() -> Void)?  // Currently not used
        }
        
        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
        func applyViewUpdates(to viewController: UpdatableVC, includeSubDepth: Bool) {
            self.viewUpdateHandlers.values.forEach { $0(viewController) }
            
            guard includeSubDepth else { return }
        }        
    }
}
