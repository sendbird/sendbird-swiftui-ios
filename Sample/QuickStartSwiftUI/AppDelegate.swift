//
//  AppDelegate.swift
//  QuickStartSwiftUI
//
//  Created by Celine Moon on 7/11/24.
//

import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        
        return true
    }
    
    func registerRemoteNotifications() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        center.requestAuthorization(options: [.sound, .alert]) { _, _ in
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    // MARK: Registering Remote Notifications
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        SendbirdUI.registerPush(deviceToken: deviceToken) { success in
            
        }
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("[QuickStartSwiftUI] 🚨 Failed to register for Remote Notifications. \(error)")
    }
}

extension AppDelegate {
    // MARK: Receiving Remote Notifications
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        let userInfo = response.notification.request.content.userInfo
        
//        guard let payload: NSDictionary = userInfo["sendbird"] as? NSDictionary, 
//              let channel: NSDictionary = payload["channel"] as? NSDictionary,
//              let channelURL: String = channel["channel_url"] as? String else { return }
        
        if let userID = UserDefaults.loadUserID(), let nickname = UserDefaults.loadNickname() {
            SBUGlobals.currentUser = SBUUser(userId: userID, nickname: nickname)
            SendbirdUI.PushPayloadManager.save(userInfo: userInfo)
        }
    }
}
