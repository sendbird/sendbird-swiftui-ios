//
//  SendbirdUI+SwiftUI.swift
//  SendbirdUIKit
//
//  Created by Kai Lee on 7/5/24.
//

import SwiftUI
import SendbirdChatSDK

extension SendbirdUI {
    static func findChannelListViewControllerFromSwiftUI(rootViewController: UIViewController?,
                                                                channelType: ChannelType) -> UIViewController? {
        guard let rootHostingViewController = rootViewController else {
            return nil
        }
        
        var stack: [UIViewController] = [rootHostingViewController]
        while !stack.isEmpty {
            let currentViewController = stack.removeFirst()
            
            // The channel list will be found before the channel
            // because the search is performed breadth-first
            if matchChannelListViewController(currentViewController, channelType: channelType)
                || matchChannelViewController(currentViewController, channelType: channelType) {
                return currentViewController
            }
            
            stack.append(contentsOf: currentViewController.children)
        }
        
        return nil
    }
}

// MARK: - Push notification
import Combine
extension SendbirdUI {
    public class PushPayloadManager: ObservableObject {
        /// All published event should be received on main thread
        /// to prevent data race
        static let shared = PushPayloadManager()
        
        @Published private(set) var payload: [AnyHashable: Any] = [:]
        @Published private(set) var channel: [AnyHashable: Any] = [:]
        @Published private(set) var channelURL: String?
        
        public static func save(userInfo: [AnyHashable: Any]) {
            if
                let sendbirdPayload = userInfo["sendbird"] as? [AnyHashable: Any],
                let channel = sendbirdPayload["channel"] as? [AnyHashable: Any]
            {
                shared.payload = sendbirdPayload
                shared.channel = channel
                shared.channelURL = channel["channel_url"] as? String
            } else {
                SBULog.error("Sendbird payload not found")
            }
        }
        
        public static var pushNotificationPublisher: AnyPublisher<String, Never> {
            shared.$channelURL
                .compactMap { $0 }
                .eraseToAnyPublisher()
        }
        
        func clear() {
            payload = [:]
            channel = [:]
            channelURL = nil
        }
    }
}
