//
//  ViewItemInitialize.swift
//  SendbirdUIKit
//
//  Created by Kai Lee on 8/8/24.
//

import Foundation

// for `headerItem { .init() }`
protocol ViewItemInitialize {
    init()
}

extension ViewItemInitialize {
    static func setup() -> Self { Self.init() }
}
