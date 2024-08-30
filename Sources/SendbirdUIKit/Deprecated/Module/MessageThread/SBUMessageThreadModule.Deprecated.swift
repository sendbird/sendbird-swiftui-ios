//
//  SBUMessageThreadModule.Deprecated.swift
//  SendbirdUIKit
//
//  Created by Tez Park on 5/2/24.
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

/// The class that represents the message thread module.
open class SBUMessageThreadModule {
    /// The module component that contains `titleView`, `leftBarButton`, and `rightBarButton`.
    ///
    /// The default function of each button is as below:
    /// - `title`: Shows the channel name. It uses ``SBUMessageThreadTitleView`` as a default.
    /// - `leftBarButton`: Not set.
    /// - `rightBarButton`: Not set.
    @available(*, deprecated, message: "Use `SBUMessageThreadModule.HeaderComponent` instead.")
    public var headerComponent: SBUMessageThreadModule.Header? {
        get { _headerComponent ?? Self.HeaderComponent.init() }
        set {
            _headerComponent = newValue
            if let validNewValue = newValue {
                Self.HeaderComponent = type(of: validNewValue)
            }
        }
    }
    
    /// The module component that shows the list of thread message in the channel.
    @available(*, deprecated, message: "Use `SBUMessageThreadModule.ListComponent` instead.")
    public var listComponent: SBUMessageThreadModule.List? {
        get { _listComponent ?? Self.ListComponent.init() }
        set {
            _listComponent = newValue
            if let validNewValue = newValue {
                Self.ListComponent = type(of: validNewValue)
            }
        }
    }
    
    /// The module component that contains `messageInputView`.
    @available(*, deprecated, message: "Use `SBUMessageThreadModule.InputComponent` instead.")
    public var inputComponent: (SBUMessageThreadModule.Input)? {
        get { _inputComponent ?? Self.InputComponent.init() }
        set {
            _inputComponent = newValue
            if let validNewValue = newValue {
                Self.InputComponent = type(of: validNewValue)
            }
        }
    }
    
    // MARK: Properties (Holder)
    private var _headerComponent: SBUMessageThreadModule.Header?
    private var _listComponent: SBUMessageThreadModule.List?
    private var _inputComponent: (SBUMessageThreadModule.Input)?
    
    // MARK: -
    /// Default initializer
    public required init() {}
    
    /// Initializes module with components.
    @available(*, deprecated, message: "Use `SBUModuleSet.MessageThreadModule")
    public required init(
        headerComponent: SBUMessageThreadModule.Header?
    ) {
        self.headerComponent = headerComponent
    }
    
    /// Initializes module with components.
    @available(*, deprecated, message: "Use `SBUModuleSet.MessageThreadModule")
    public required init(
        listComponent: SBUMessageThreadModule.List?
    ) {
        self.listComponent = listComponent
    }
    
    /// Initializes module with components.
    @available(*, deprecated, message: "Use `SBUModuleSet.MessageThreadModule")
    public required init(
        inputComponent: (SBUMessageThreadModule.Input)?
    ) {
        self.inputComponent = inputComponent
    }
    
    /// Initializes module with components.
    @available(*, deprecated, message: "Use `SBUModuleSet.MessageThreadModule")
    public required init(
        headerComponent: SBUMessageThreadModule.Header?,
        listComponent: SBUMessageThreadModule.List?
    ) {
        self.headerComponent = headerComponent
        self.listComponent = listComponent
    }
    
    /// Initializes module with components.
    @available(*, deprecated, message: "Use `SBUModuleSet.MessageThreadModule")
    public required init(
        headerComponent: SBUMessageThreadModule.Header?,
        inputComponent: (SBUMessageThreadModule.Input)?
    ) {
        self.headerComponent = headerComponent
        self.inputComponent = inputComponent
    }
    
    /// Initializes module with components.
    @available(*, deprecated, message: "Use `SBUModuleSet.MessageThreadModule")
    public required init(
        listComponent: SBUMessageThreadModule.List?,
        inputComponent: (SBUMessageThreadModule.Input)?
    ) {
        self.listComponent = listComponent
        self.inputComponent = inputComponent
    }
    
    /// Initializes module with components.
    @available(*, deprecated, message: "Use `SBUModuleSet.MessageThreadModule")
    public required init(
        headerComponent: SBUMessageThreadModule.Header?,
        listComponent: SBUMessageThreadModule.List?,
        inputComponent: (SBUMessageThreadModule.Input)?
    ) {
        self.headerComponent = headerComponent
        self.listComponent = listComponent
        self.inputComponent = inputComponent
    }
}
