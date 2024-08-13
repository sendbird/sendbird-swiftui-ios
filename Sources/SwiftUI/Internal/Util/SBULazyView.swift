//
//  SBULazyView.swift
//  SendbirdSwiftUI
//
//  Created by Tez Park on 6/11/24.
//

import SwiftUI

struct SBULazyView<Content: View>: View {
    let build: () -> Content
    let onAppearAction: () -> Void
    let onDisappearAction: () -> Void

    init(
        build: @escaping () -> Content,
        onAppearAction: @escaping () -> Void = {},
        onDisappearAction: @escaping () -> Void = {}
    ) {
        self.build = build
        self.onAppearAction = onAppearAction
        self.onDisappearAction = onDisappearAction
    }
    
    var body: some View {
        build()
            .onAppear(perform: onAppearAction)
            .onDisappear(perform: onDisappearAction)
    }
}
