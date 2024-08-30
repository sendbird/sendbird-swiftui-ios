//
//  SBUGroupChannelModule.Deprecated.swift
//  SendbirdUIKit
//
//  Created by Tez Park on 5/2/24.
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

/// The class that represents the group channel module
open class SBUGroupChannelModule {
    /// The module component that contains `titleView`, `leftBarButton`, and `rightBarButton`
    /// - NOTE: The default function of each button is as below:
    ///     - `title`: Shows the group channel name
    ///     - `leftBarButton`: Goes back to the previous view.
    ///     - `rightBarButton`: Shows the group channel settings.
    @available(*, deprecated, message: "Use `SBUGroupChannelModule.HeaderComponent` instead.")
    public var headerComponent: SBUGroupChannelModule.Header? {
        get { _headerComponent ?? Self.HeaderComponent.init() }
        set {
            _headerComponent = newValue
            if let validNewValue = newValue {
                Self.HeaderComponent = type(of: validNewValue)
            }
        }
    }
    
    /// The module component that shows the list of message in the group channel.
    @available(*, deprecated, message: "Use `SBUGroupChannelModule.ListComponent` instead.")
    public var listComponent: SBUGroupChannelModule.List? {
        get { _listComponent ?? Self.ListComponent.init() }
        set {
            _listComponent = newValue
            if let validNewValue = newValue {
                Self.ListComponent = type(of: validNewValue)
            }
        }
    }
    
    /// The module component that contains `messageInputView`.
    @available(*, deprecated, message: "Use `SBUGroupChannelModule.InputComponent` instead.")
    public var inputComponent: SBUGroupChannelModule.Input? {
        get { _inputComponent ?? Self.InputComponent.init() }
        set {
            _inputComponent = newValue
            if let validNewValue = newValue {
                Self.InputComponent = type(of: validNewValue)
            }
        }
    }
    
    // MARK: Properties (Holder)
    private var _headerComponent: SBUGroupChannelModule.Header?
    private var _listComponent: SBUGroupChannelModule.List?
    private var _inputComponent: SBUGroupChannelModule.Input?
    
    // MARK: -
    /// Default initializer
    public required init() {}
    
    // swiftlint:disable missing_docs
    @available(*, deprecated, message: "Use `SBUModuleSet.GroupChannelModule`")
    public required init(
        headerComponent: SBUGroupChannelModule.Header?
    ) {
        self._headerComponent = headerComponent
    }
    
    @available(*, deprecated, message: "Use `SBUModuleSet.GroupChannelModule`")
    public required init(
        listComponent: SBUGroupChannelModule.List?
    ) {
        self._listComponent = listComponent
    }
    
    @available(*, deprecated, message: "Use `SBUModuleSet.GroupChannelModule`")
    public required init(
        inputComponent: SBUGroupChannelModule.Input?
    ) {
        self._inputComponent = inputComponent
    }
    
    @available(*, deprecated, message: "Use `SBUModuleSet.GroupChannelModule`")
    public required init(
        headerComponent: SBUGroupChannelModule.Header?,
        listComponent: SBUGroupChannelModule.List?
    ) {
        self._headerComponent = headerComponent
        self._listComponent = listComponent
    }
    
    @available(*, deprecated, message: "Use `SBUModuleSet.GroupChannelModule`")
    public required init(
        headerComponent: SBUGroupChannelModule.Header?,
        inputComponent: SBUGroupChannelModule.Input?
    ) {
        self._headerComponent = headerComponent
        self._inputComponent = inputComponent
    }
    
    @available(*, deprecated, message: "Use `SBUModuleSet.GroupChannelModule`")
    public required init(
        listComponent: SBUGroupChannelModule.List?,
        inputComponent: SBUGroupChannelModule.Input?
    ) {
        self._listComponent = listComponent
        self._inputComponent = inputComponent
    }
    
    @available(*, deprecated, message: "Use `SBUModuleSet.GroupChannelModule`")
    public required init(
        headerComponent: SBUGroupChannelModule.Header?,
        listComponent: SBUGroupChannelModule.List?,
        inputComponent: SBUGroupChannelModule.Input?
    ) {
        self._headerComponent = headerComponent
        self._listComponent = listComponent
        self._inputComponent = inputComponent
    }
    // swiftlint:enable missing_docs
}
