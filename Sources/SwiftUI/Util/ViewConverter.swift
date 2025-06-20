//
//  ViewConverter.swift
//  SendbirdUIKit
//
//  Created by Celine Moon on 6/19/24.
//

import UIKit

struct ViewConverter<T> {
    private var converter: (T) -> UIView?

    init(_ converter: @escaping (T) -> UIView?) {
        self.converter = converter
    }

    @discardableResult
    func callAsFunction(_ param: T) -> UIView? {
        converter(param)
    }
}

protocol ViewConfigurations {}

/// A way to pass update data between in the SwiftUI wrapper's view update cycle and SendbirdUIKit's view update cycle.
/// - Since: 1.1.0
protocol ViewUpdateDataType { }

protocol ViewConverterProtocol: ViewUpdateHandlerProtocol {
    associatedtype EntireContentArgs: ViewConfigurations
    var entireContent: ViewConverter<EntireContentArgs>? { get set }
}

protocol ViewUpdateHandlerProtocol {
    associatedtype UpdatableVCType
    associatedtype ViewType: ViewTypeEnum
    associatedtype ViewUpdateData: ViewUpdateDataType
    
    var viewUpdateHandlers: [ViewType: (UpdatableVCType) -> Void] { get set }
    func applyViewUpdates(to viewController: UpdatableVCType, includeSubDepth: Bool)
    
    /// Data that need to be passed into `applyViewConverter(...)` method of each UIKit views
    /// when calling it from `applyViewUpdates(to:includeSubDepth)`.
    /// To see a use case, see ``func topView<Content: View>``  in ``Sendbird.View.GroupChannel.Channel.InputItem``.
    /// - Since: 1.1.0
    var viewUpdateData: ViewUpdateDataType? { get set }
    
    /// Updates the `viewUpdateData` in `SBViewConverterSet` from UIKit side.
    /// To see a use case, see SBUMessageInputView+SwiftUI.
    /// - Since: 1.1.0
    mutating func updateViewUpdateData(_ viewUpdateData: ViewUpdateData)
}

extension ViewUpdateHandlerProtocol {
     var viewUpdateData: ViewUpdateDataType? {
         get { return nil }
         set { /* No-op by default */ }
     }
    
    func applyViewUpdates(to viewController: UpdatableVCType, includeSubDepth: Bool = true) {
        self.viewUpdateHandlers.values.forEach { $0(viewController) }
        
        // INFO: If there are sub-properties inside the logic, we need to implement them
        // ```
        // guard includeSubDepth else { return }
        // subView.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
        // ```
    }
    
    mutating func updateViewUpdateData(_ viewUpdateData: ViewUpdateData) {
        self.viewUpdateData = viewUpdateData
    }
}

protocol ViewTypeEnum: CaseIterable, Hashable, Taggable {
    var rawValue: Int { get }
    static var allCases: [Self] { get }
}

extension ViewTypeEnum {
    var rawValue: Int { Self.allCases.firstIndex(where: { $0 == self })! + 1 }
}

extension ViewTypeEnum {
    func baseTag() -> Int { TagManager.tag(for: Self.self) }
    
    var tag: Int { (self.baseTag() * 1_000) + self.rawValue } // (1_000_000) -> 1_{base_tag}_{view_type_raw_value}
}

protocol Taggable {
    func baseTag() -> Int
}

class TagManager {
    static var tagCounter = 1_000
    private static var tagStore: [ObjectIdentifier: Int] = [:]

    static func tag(for type: Any.Type) -> Int {
        let typeName = ObjectIdentifier(type)
        
        if let tag = self.tagStore[typeName] { return tag }
        
        self.tagCounter += 1
        self.tagStore[typeName] = self.tagCounter
        return self.tagCounter
    }
}
