//
//  SBUTemplateType.swift
//  SendbirdUIKit
//
//  Created by Damon Park on 2024/02/19.
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import UIKit
import SendbirdChatSDK

enum SBUTemplateType {
    case notification
    case group
    
    var cacheKey: String {
        switch self {
        case .notification: return "template" // NOTE: for backward
        case .group: return "group-template"
        }
    }
    
    var templateKey: String {
        switch self {
        case .notification: return "template_key"
        case .group: return "key"
        }
    }
    
    var dataVariable: String {
        switch self {
        case .notification: return "template_variables"
        case .group: return "variables"
        }
    }
    
    var viewVariable: String {
        switch self {
        case .notification: return "template_view_variables"
        case .group: return "view_variables"
        }
    }
}

enum SBUTemplateThemeType: String {
    case light
    case dark
    case `default`
    
    static func type(with themeMode: String?) -> SBUTemplateThemeType? {
        SBUTemplateThemeType(rawValue: themeMode ?? "")
    }
}

extension SBUTemplateType {
    func getRemoteToken() -> Int64 {
        switch self {
        case .notification:
            return Int64(SendbirdChat.getAppInfo()?.notificationInfo?.templateListToken ?? "0") ?? 0

        case .group:
            return Int64(SendbirdChat.getAppInfo()?.messageTemplateInfo?.templateListToken ?? "0") ?? 0
        }
    }
    
    func loadTemplate(
        key: String,
        completionHandler: @escaping (_ payload: String?, _ error: Error?) -> Void
    ) {
        switch self {
        case .notification:
            SendbirdChat.getNotificationTemplate(key: key) { template, error in
                completionHandler(template?.jsonPayload, error)
            }

        case .group:
            SendbirdChat.getMessageTemplate(key: key) { template, error in
                completionHandler(template?.jsonPayload, error)
            }
        }
    }

    func loadTemplateList(
        token: String?,
        completionHandler: @escaping (_ payload: String?, _ token: String?) -> Void
    ) {
        switch self {
        case .notification:
            let params = NotificationTemplateListParams { $0.limit = 100 }
            SendbirdChat.getNotificationTemplateList(token: token, params: params) { templateList, _, token, _ in
                completionHandler(templateList?.jsonPayload, token)
            }
        case .group:
            let params = MessageTemplateListParams { $0.limit = 100 }
            SendbirdChat.getMessageTemplateList(token: token, params: params) { templateList, _, token, _ in
                completionHandler(templateList?.jsonPayload, token)
            }
        }
    }
}
