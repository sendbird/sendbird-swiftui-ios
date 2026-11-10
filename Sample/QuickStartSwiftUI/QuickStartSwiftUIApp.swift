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
            #if SBISSUE_MODE
            // 컨테이너 계층 자체가 트리거인 재현 케이스는 LoginView 를 거치지 않는다.
            // LoginView 의 NavigationLink 가 케이스 위에 스택을 한 겹 깔기 때문이다.
            if let item = SBISSUERootLaunch.requestedCase {
                SBISSUEConnectGate(item: item)
            } else {
                LoginView()
            }
            #else
            LoginView()
            #endif
        }
    }
}
