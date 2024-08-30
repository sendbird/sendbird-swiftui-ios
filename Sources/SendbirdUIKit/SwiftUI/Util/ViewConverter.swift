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

protocol ViewConverterProtocol: ViewUpdateHandlerProtocol {
    associatedtype EntireContentArgs: ViewConfigurations
    var entireContent: ViewConverter<EntireContentArgs>? { get set }
}

protocol ViewUpdateHandlerProtocol {
    associatedtype UpdatableVCType
    associatedtype ViewType: ViewTypeEnum
    
    var viewUpdateHandlers: [ViewType: (UpdatableVCType) -> Void] { get set }
    func applyViewUpdates(to viewController: UpdatableVCType, includeSubDepth: Bool)
}

extension ViewUpdateHandlerProtocol {
    func applyViewUpdates(to viewController: UpdatableVCType, includeSubDepth: Bool = true) {
        self.viewUpdateHandlers.values.forEach { $0(viewController) }
        
        // INFO: If there are sub-properties inside the logic, we need to implement them
        // ```
        // guard includeSubDepth else { return }
        // subView.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
        // ```
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
