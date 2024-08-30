//
//  ViewItemProtocol.swift
//  SendbirdSwiftUI
//
//  Created by Tez Park on 6/27/24.
//

import SwiftUI

//typealias ViewItemProtocol = ViewItemType & ViewItemInitialize

// protocol ViewItemType {
protocol ViewItemProtocol {
    associatedtype ViewConverterType
    associatedtype ViewContent
    
    var viewConverter: ViewConverterType { get set}
    
    func createViewConverter<Content: View, Config: ViewConfigurations>(
        content: @escaping (Config) -> Content
    ) -> ViewConverter<Config>
}

// extension ViewItemType {
extension ViewItemProtocol {
    func createViewConverter<Content: View, Config: ViewConfigurations>(
        content: @escaping (Config) -> Content
    ) -> ViewConverter<Config> {
        return ViewConverter { config in
            let view = UIHostingController(rootView: content(config)).view
            view?.backgroundColor = .clear
            return view
        }
    }
}
