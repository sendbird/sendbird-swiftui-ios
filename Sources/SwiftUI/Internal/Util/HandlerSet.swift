//
//  HandlerSet.swift
//  SendbirdUIKit
//
//  Created by Kai Lee on 5/22/24.
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import Foundation

// ----------------------
// MARK: - ViewController
// ----------------------
class ViewControllerHandlerSet<T> {
    var loadView: Closure<T, Void>?
    var viewDidLoad: Closure<T, Void>?
    var viewWillAppear: Closure<(T, animated: Bool), Void>?
    
    var setupViews: Closure<T, Void>?
    var setupLayouts: Closure<T, Void>?
    var updateLayouts: Closure<T, Void>?
    var setupStyles: Closure<T, Void>?
    var updateStyles: Closure<T, Void>?
    
    // swiftlint:disable:next large_tuple
    var errorHandler: Closure<(T, message: String?, code: Int), Void>?
    // TODO: Add more...
}

class ViewControllerProtocolHandlerSet<T> {
    var showLoading: Closure<(T, isLoading: Bool), Void>?
    // TODO: Add more...
}

// -------------
// MARK: - View
// -------------
class ViewHandlerSet<T> {
    var setupViews: Closure<T, Void>?
    var setupLayouts: Closure<T, Void>?
    var updateLayouts: Closure<T, Void>?
    var setupStyles: Closure<T, Void>?
    var updateStyles: Closure<T, Void>?
    var setupActions: Closure<T, Void>?
    
    // TODO: Add more...
}

class ViewProtocolHandlerSet<T> {
    // TODO: Add more...
}

// -----------------
// MARK: - ViewModel
// -----------------
class ViewModelHandlerSet<T> {
    // TODO: Add more...
}

class ViewModelProtocolHandlerSet<T> {
    // TODO: Add more...
}
