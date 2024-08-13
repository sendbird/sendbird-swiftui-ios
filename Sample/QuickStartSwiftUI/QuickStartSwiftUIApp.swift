//
//  QuickStartSwiftUIApp.swift
//  QuickStartSwiftUI
//
//  Created by Celine Moon on 7/11/24.
//

import SwiftUI

@main
struct QuickStartSwiftUIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self)
    var delegate
    
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}
