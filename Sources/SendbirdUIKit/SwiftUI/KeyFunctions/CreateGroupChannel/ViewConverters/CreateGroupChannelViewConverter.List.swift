//
//  CreateGroupChannelView+ViewConverter.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SendbirdChatSDK
import UIKit

// MARK: List
extension CreateGroupChannelViewConverter {
    public struct List: ViewConverterProtocol {
        // MARK: TypeAlias
        public typealias ContentBaseArg = SBUCreateChannelModule.List
        typealias UpdatableVC = SBUCreateChannelViewController

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

extension CreateGroupChannelViewConverter.List {
    public struct TableView: ViewConverterProtocol {
        // MARK: TypeAlias
        typealias UpdatableVC = CreateGroupChannelViewConverter.List.UpdatableVC
        
        // MARK: ViewType
        enum ViewType: ViewTypeEnum {
            case entireContent  // entire cell content
        }

        // MARK: Converter
        var entireContent: ViewConverter<ViewConfig>?
        var rowView = RowView()
        
        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {
            public var parentView: ContentBaseArg
            public var users: [SBUUser] = []
            public var selectedUsers: [SBUUser] = []
        }
        
        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
        func applyViewUpdates(to viewController: UpdatableVC, includeSubDepth: Bool) {
            self.viewUpdateHandlers.values.forEach { $0(viewController) }
            
            guard includeSubDepth else { return }
            
            self.rowView.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
        }
    }
}

extension CreateGroupChannelViewConverter.List.TableView {
    public struct RowView: ViewConverterProtocol {
        // MARK: TypeAlias
        typealias UpdatableVC = CreateGroupChannelViewConverter.List.UpdatableVC

        // MARK: ViewType
        enum ViewType: ViewTypeEnum {
            case entireContent  // entire cell content
            case profileImage
            case userNameLabel
            case selectionButton
        }

        // MARK: Converter
        var entireContent: ViewConverter<ViewConfig>? {
            didSet { self.entireContent?(.init()) }
        }
        var profileImage = ProfileImage()
        var userNameLabel = UserNameLabel()
        var selectionButton = SelectionButton()

        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {
            public var user: SBUUser = DefaultViewConfigSet.sbuUser
            public var height: CGFloat = DefaultViewConfigSet.userCellHeight
            public var isChecked: Bool = false
            public var operatorMode: Bool = false
        }

        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
        func applyViewUpdates(to viewController: UpdatableVC, includeSubDepth: Bool) {
            self.viewUpdateHandlers.values.forEach { $0(viewController) }

            guard includeSubDepth else { return }
            self.profileImage.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
            self.userNameLabel.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
            self.selectionButton.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
        }
    }
}

extension CreateGroupChannelViewConverter.List.TableView.RowView {
    public struct ProfileImage: ViewConverterProtocol {
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
            public var user: SBUUser = DefaultViewConfigSet.sbuUser
            public var profileURL: String = ""
            public var imageSize: CGSize = DefaultViewConfigSet.userCellProfileImageSize
            public var isChecked: Bool = false
            public var operatorMode: Bool = false
        }

        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
    }
    
    public struct UserNameLabel: ViewConverterProtocol {
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
            public var user: SBUUser = DefaultViewConfigSet.sbuUser
            public var nickname: String = ""
            public var isChecked: Bool = false
            public var operatorMode: Bool = false
        }

        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
    }
    
    public struct SelectionButton: ViewConverterProtocol {
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
            public var user: SBUUser = DefaultViewConfigSet.sbuUser
            public var isChecked: Bool = false
            public var operatorMode: Bool = false
            public var buttonSize: CGSize = DefaultViewConfigSet.userCellCheckBoxSize
        }

        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
    }
}
