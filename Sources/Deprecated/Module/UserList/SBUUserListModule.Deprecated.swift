//
//  SBUUserListModule.Deprecated.swift
//  SendbirdUIKit
//
//  Created by Tez Park on 5/2/24.
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

/// The class that represents the module for multiple types of the user list.
open class SBUUserListModule {
    /// The module component that contains `titleView`, `leftBarButton`, and `rightBarButton`.
    ///
    /// The default function of each button is as below:
    /// - `title`: Shows the title according to the type of user list.
    /// - `leftBarButton`: Goes back to the previous view.
    /// - `rightBarButton`: Shows the add button. (The button is set or not set according to the type of user list.)
    @available(*, deprecated, message: "Use `SBUUserListModule.HeaderComponent` instead.")
    public var headerComponent: SBUUserListModule.Header? {
        get { _headerComponent ?? Self.HeaderComponent.init() }
        set {
            _headerComponent = newValue
            if let validNewValue = newValue {
                Self.HeaderComponent = type(of: validNewValue)
            }
        }
    }
    
    /// The module component that shows the list of users.
    @available(*, deprecated, message: "Use `SBUUserListModule.ListComponent` instead.")
    public var listComponent: SBUUserListModule.List? {
        get { _listComponent ?? Self.ListComponent.init() }
        set {
            _listComponent = newValue
            if let validNewValue = newValue {
                Self.ListComponent = type(of: validNewValue)
            }
        }
    }
    
    // MARK: Properties (Holder)
    private var _headerComponent: SBUUserListModule.Header?
    private var _listComponent: SBUUserListModule.List?
    
    // MARK: -
    /// Default initializer
    public required init() {}
    
    /// Initializes module with components.
    @available(*, deprecated, message: "Use `SBUModuleSet.GroupUserListModule` or `SBUModuleSet.OpenUserListModule`")
    public required init(
        headerComponent: SBUUserListModule.Header? = nil
    ) {
        self.headerComponent = headerComponent
    }
    
    /// Initializes module with components.
    @available(*, deprecated, message: "Use `SBUModuleSet.GroupUserListModule` or `SBUModuleSet.OpenUserListModule`")
    public required init(
        listComponent: SBUUserListModule.List? = nil
    ) {
        self.listComponent = listComponent
    }
    
    /// Initializes module with components.
    @available(*, deprecated, message: "Use `SBUModuleSet.GroupUserListModule` or `SBUModuleSet.OpenUserListModule`")
    public required init(
        headerComponent: SBUUserListModule.Header? = nil,
        listComponent: SBUUserListModule.List? = nil
    ) {
        self.headerComponent = headerComponent
        self.listComponent = listComponent
    }
}
