//
//  ProviderWrappedHostingView.swift
//  SendbirdUIKit
//
//  Created by Tez Park on 11/8/24.
//

import SwiftUI

struct ProviderWrappedHostingView<Provider: ObservableObject, Content: View>: View {
    @ObservedObject var provider: Provider
    let content: () -> Content
    
    init(
        provider: Provider,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.provider = provider
        self.content = content
    }
    
    func createHostingView() -> UIView {
        let hostingController = UIHostingController(rootView: self)
        return hostingController.view
    }
    
    var body: some View {
        content()
    }
}

struct ProviderAndConfigWrappedHostingView<Provider: ObservableObject, Config: ViewConfigurations, Content: View>: View {
    @ObservedObject var provider: Provider
    let content: () -> Content
    
    init(
        provider: Provider,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.provider = provider
        self.content = content
    }
    
    init(
        provider: Provider,
        config: Config,
        @ViewBuilder content: @escaping (Config) -> Content
    ) {
        self.provider = provider
        self.content = { content(config) }
    }
    
    func createHostingView() -> UIView {
        let hostingController = UIHostingController(rootView: self)
        return hostingController.view
    }
    
    var body: some View {
        content()
    }
}
