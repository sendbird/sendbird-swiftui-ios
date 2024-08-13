//
//  UserDefaults+Ext.swift
//  QuickStartSwiftUI
//
//  Created by Celine Moon on 7/12/24.
//

import Foundation

extension UserDefaults {
    enum Keys: String {
        case appID
        case userID
        case nickname
    
    }
    
    static func saveLogInInfo(appId: String, userId: String, nickname: String) {
        UserDefaults.standard.set(appId, forKey: Keys.appID.rawValue)
        UserDefaults.standard.set(userId, forKey: Keys.userID.rawValue)
        UserDefaults.standard.set(nickname, forKey: Keys.nickname.rawValue)
    }
    
    static func loadLogInInfo() {
        let appID = UserDefaults.standard.string(forKey: Keys.appID.rawValue)
        let userID = UserDefaults.standard.string(forKey: Keys.userID.rawValue)
        let nickname = UserDefaults.standard.string(forKey: Keys.nickname.rawValue)
        print("\(String(describing: appID)) / \(String(describing: userID)) / \(String(describing: nickname))")
    }
    
    static func removeLogInInfo() {
        UserDefaults.standard.removeObject(forKey: Keys.appID.rawValue)
        UserDefaults.standard.removeObject(forKey: Keys.userID.rawValue)
        UserDefaults.standard.removeObject(forKey: Keys.nickname.rawValue)
    }
    
    static func loadUserID() -> String? {
        return UserDefaults.standard.string(forKey: Keys.userID.rawValue)
    }
    
    static func loadNickname() -> String? {
        return UserDefaults.standard.string(forKey: Keys.nickname.rawValue)
    }
    
    static func updateNickname(nickname: String) {
        UserDefaults.standard.set(nickname, forKey: Keys.nickname.rawValue)
    }
}
