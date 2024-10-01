//
//  View + ViewModifier.swift
//  SendbirdUIKit
//
//  Created by Kai Lee on 5/10/24.
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SwiftUI

extension View {
    /// Hide the SwiftUI navigation back button
    func hideSwiftUINavigationBackButton() -> some View {
        self
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("")
                }
            }
    }
    
    func switchUIKitNavigationBar() -> some View {
        self
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .ignoresSafeArea()
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .navigationBarHidden(true)
    }
}
