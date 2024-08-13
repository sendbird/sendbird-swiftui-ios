//
//  OpenBannedUserListView+ViewConverter.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SendbirdChatSDK
import UIKit

// MARK: List
extension OpenBannedUserListViewConverter {
    public struct List: ViewConverterProtocol {
        // MARK: TypeAlias
        public typealias ContentBaseArg = SBUUserListModule.List
        typealias UpdatableVC = SBUUserListViewController

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

extension OpenBannedUserListViewConverter.List {
    public struct TableView: ViewConverterProtocol {
        // MARK: TypeAlias
        typealias UpdatableVC = OpenBannedUserListViewConverter.List.UpdatableVC
        
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

extension OpenBannedUserListViewConverter.List.TableView {
    public struct RowView: ViewConverterProtocol {
        // MARK: TypeAlias
        typealias UpdatableVC = OpenBannedUserListViewConverter.List.UpdatableVC

        // MARK: ViewType
        enum ViewType: ViewTypeEnum {
            case entireContent  // entire cell content
            case profileImage
            case userNameLabel
            case moreButton
        }

        // MARK: Converter
        var entireContent: ViewConverter<ViewConfig>? {
            didSet { self.entireContent?(.init()) }
        }
        var profileImage = ProfileImage()
        var userNameLabel = UserNameLabel()
        var moreButton = MoreButton()

        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {
            public var user: SBUUser = DefaultViewConfigSet.sbuUser
            public var height: CGFloat = DefaultViewConfigSet.userCellHeight
            public var isOperator: Bool = false
        }

        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
        func applyViewUpdates(to viewController: UpdatableVC, includeSubDepth: Bool) {
            self.viewUpdateHandlers.values.forEach { $0(viewController) }

            guard includeSubDepth else { return }
            self.profileImage.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
            self.userNameLabel.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
            self.moreButton.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
        }
    }
}

extension OpenBannedUserListViewConverter.List.TableView.RowView {
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
            public var isOperator: Bool = false
            public var profileURL: String = ""
            public var imageSize: CGSize = DefaultViewConfigSet.userCellProfileImageSize
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
            public var isOperator: Bool = false
        }

        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
    }
    
    public struct MoreButton: ViewConverterProtocol {
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
            public var isOperatorMode: Bool = false
            public var buttonWidth: CGFloat = DefaultViewConfigSet.userCellMoreButtonWidth
        }

        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
    }
}
