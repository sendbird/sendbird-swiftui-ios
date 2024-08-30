//
//  SBUModerationsModule.Deprecated.swift
//  SendbirdUIKit
//
//  Created by Tez Park on 5/2/24.
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

/// The class that represents the moderation module.
open class SBUModerationsModule {
    // MARK: Properties (Public)
    
    /// The module component that contains `titleView`, `leftBarButton`, and `rightBarButton`.
    ///
    /// The default function of each button is as below:
    /// - `title`: Shows the moderation view's title.
    /// - `leftBarButton`: Goes back to the previous view.
    /// - `rightBarButton`: Not set.
    @available(*, deprecated, message: "Use `SBUModerationsModule.HeaderComponent` instead.")
    public var headerComponent: SBUModerationsModule.Header? {
        get { _headerComponent ?? Self.HeaderComponent.init() }
        set {
            _headerComponent = newValue
            if let validNewValue = newValue {
                Self.HeaderComponent = type(of: validNewValue)
            }
        }
    }
    
    /// The module component that shows the list of moderation items in the channel.
    @available(*, deprecated, message: "Use `SBUModerationsModule.ListComponent` instead.")
    public var listComponent: SBUModerationsModule.List? {
        get { _listComponent ?? Self.ListComponent.init() }
        set {
            _listComponent = newValue
            if let validNewValue = newValue {
                Self.ListComponent = type(of: validNewValue)
            }
        }
    }
    
    // MARK: Properties (Holder)
    private var _headerComponent: SBUModerationsModule.Header?
    private var _listComponent: SBUModerationsModule.List?
    
    // MARK: -
    /// Default initializer
    public required init() {}
    
    /// Initializes module with components.
    @available(*, deprecated, message: "Use `SBUModuleSet.OpenModerationsModule` or `SBUModuleSet.GroupModerationsModule`")
    public required init(
        headerComponent: SBUModerationsModule.Header?
    ) {
        self.headerComponent = headerComponent
    }
    
    /// Initializes module with components.
    @available(*, deprecated, message: "Use `SBUModuleSet.OpenModerationsModule` or `SBUModuleSet.GroupModerationsModule`")
    public required init(
        listComponent: SBUModerationsModule.List?
    ) {
        self.listComponent = listComponent
    }
    
    /// Initializes module with components.
    @available(*, deprecated, message: "Use `SBUModuleSet.OpenModerationsModule` or `SBUModuleSet.GroupModerationsModule`")
    public required init(
        headerComponent: SBUModerationsModule.Header?,
        listComponent: SBUModerationsModule.List?
    ) {
        self.headerComponent = headerComponent
        self.listComponent = listComponent
    }
}
