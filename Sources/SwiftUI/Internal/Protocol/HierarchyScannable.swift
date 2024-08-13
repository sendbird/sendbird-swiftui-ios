//
//  HierarchyScannable.swift
//  SendbirdUIKit
//
//  Created by Kai Lee on 5/21/24.
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import Foundation

/// A protocol that defines a type that has a depth property.
protocol HierarchyScannable {
    associatedtype Hierarchy
    var hierarchy: Hierarchy { get set }
}

extension HierarchyScannable {
    func ultimate<Parameter, Return, Substructure>(
        behavior: Closure<Parameter, Return>.CallBehavior,
        depth pathToComponent: WritableKeyPath<Hierarchy, Substructure>,
        handler pathToHandler: WritableKeyPath<Substructure.MethodHandlerSetType, Closure<Parameter, Return>?>,
        _ item: @escaping (Parameter) -> Return
    ) -> Self where Substructure: MethodOverridable {
        // Access the substructure of the current hierarchy
        let substructure = hierarchy[keyPath: pathToComponent]
        
        // Check if the handler is already set when debug mode
//        #if DEBUG
//        guard substructure.methodHandlerSet[keyPath: pathToHandler] == nil else {
//            fatalError("The method handler has already been set.")
//        }
//        #endif
        
        // Set a new handler
        var copy = self
        copy.hierarchy[keyPath: pathToComponent].methodHandlerSet[keyPath: pathToHandler] = Closure(behavior: behavior, closure: item)
        
        return copy
    }
    
    func ultimate<
        Parameter,
        Return,
        Substructure
    >(
        behavior: Closure<Parameter, Return>.CallBehavior,
        depth pathToComponent: WritableKeyPath<Hierarchy, Substructure>,
        handler pathToHandler: WritableKeyPath<Substructure.ProtocolHandlerSetType, Closure<Parameter, Return>?>,
        _ item: @escaping (Parameter) -> Return
    ) -> Self where Substructure: ProtocolOverridable {
        // Access the substructure of the current hierarchy
        let substructure = hierarchy[keyPath: pathToComponent]
        
        // Check if the handler is already set when debug mode
//        #if DEBUG
//        guard substructure.protocolHandlerSet[keyPath: pathToHandler] == nil else {
//            fatalError("The method handler has already been set.")
//        }
//        #endif
        
        // Set a new handler
        var copy = self
        copy.hierarchy[keyPath: pathToComponent].protocolHandlerSet[keyPath: pathToHandler] = Closure(behavior: behavior, closure: item)
        
        return copy
    }
    
    func ultimate<
        Substructure
    >(
        _ pathToComponent: WritableKeyPath<Hierarchy, Substructure>,
        _ item: @escaping (Substructure.UIKitType) -> Substructure.ReturnType
    ) -> Self where Substructure: PropertyCustmizable {
        // Set the property handler before creating a copy
        var substructure = hierarchy[keyPath: pathToComponent]
        substructure.propertyHandler = Closure(behavior: .post, closure: item)
        
        // Create a copy and set the updated substructure
        var copy = self
        copy.hierarchy[keyPath: pathToComponent] = substructure
        
        return copy
    }
}

extension HierarchyScannable {
    func override<
        Parameter,
        Return,
        Substructure: MethodOverridable
    >(
        depth pathToComponent: WritableKeyPath<Hierarchy, Substructure>,
        method pathToHandler: WritableKeyPath<Substructure.MethodHandlerSetType, Closure<Parameter, Return>?>,
        behavior: Closure<Parameter, Return>.CallBehavior,
        handler: @escaping (Parameter) -> Return
    ) -> Self {
        return ultimate(behavior: behavior, depth: pathToComponent, handler: pathToHandler, handler)
    }
    
    func override<
        Parameter,
        Return,
        Substructure: ProtocolOverridable
    >(
        depth pathToComponent: WritableKeyPath<Hierarchy, Substructure>,
        protocol pathToHandler: WritableKeyPath<Substructure.ProtocolHandlerSetType, Closure<Parameter, Return>?>,
        behavior: Closure<Parameter, Return>.CallBehavior,
        handler: @escaping (Parameter) -> Return
    ) -> Self {
        return ultimate(behavior: behavior, depth: pathToComponent, handler: pathToHandler, handler)
    }
    
    func updateOnViewCycle<
        PropertyType,
        ReturnType,
        Substructure: PropertyCustmizable
    >(
        _ pathToComponent: WritableKeyPath<Hierarchy, Substructure>,
        _ item: @escaping (PropertyType) -> ReturnType
    ) -> Self
    where
    Substructure.UIKitType == PropertyType,
    Substructure.ReturnType == ReturnType {
        return ultimate(pathToComponent, item)
    }
}
