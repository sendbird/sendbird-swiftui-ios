//
//  SBUExtendedMessage.swift
//  SendbirdUIKit
//
//  Created by Damon Park on 2023/10/23.
//  Copyright © 2023 Sendbird, Inc. All rights reserved.
//

import Foundation

/// `Structures to model `extended message` to make it easier to use
/// - Since: 3.11.0
struct SBUExtendedMessagePayload {
    /// Parsed `suggested replies` data.
    public let suggestedReplies: [String]?

    /// This is custom view data, set on the server side, and can be of `Any` type.
    public let customView: Any?
    
    /// A value that determines whether to disable the MessageInputView.
    /// - Since: 3.16.0
    public let disableChatInput: Bool?
    
    /// This is message template json dictionary string data
    /// - Since: 3.21.0
    public let template: [String: Any]?
    
    /// This is ui setting for `MessageTemplate`
    /// - Since: 3.21.0
    public let uiSettings: SBUExtendedMessagePayloadForUI?

    init?(from value: [String: Any]) {
        self.suggestedReplies = SBUExtendedMessagePayload.getSuggestedReplies(from: value)
        self.customView = SBUExtendedMessagePayload.getCustomView(from: value)
        self.disableChatInput = SBUExtendedMessagePayload.getDisableChatInput(from: value)
        self.template = SBUExtendedMessagePayload.getTemplate(from: value)
        self.uiSettings = SBUExtendedMessagePayload.getUiSettings(from: value)
    }

    enum CodingKeys: String, CodingKey {
        case suggestedReplies = "suggested_replies"
        case customView = "custom_view"
        case disableChatInput = "disable_chat_input"
        case template
        case uiSettings = "ui"
    }
    
    /// A value that determines whether to disable the MessageInputView.
    /// Additionally, other properties are checked as well.
    /// - Since: 3.16.0
    public func getDisabledChatInputState(hasNext: Bool?) -> Bool {
        if hasNext == true { return false }
        if SendbirdUI.config.groupChannel.channel.isSuggestedRepliesEnabled == false { return false }
        if (self.suggestedReplies ?? []).isEmpty == true { return false }
        return self.disableChatInput ?? false
    }
}

extension SBUExtendedMessagePayload {

    fileprivate static func getSuggestedReplies(from value: [String: Any]) -> [String]? {
        guard let json = value[CodingKeys.suggestedReplies.rawValue] else { return nil }
        guard let data = try? JSONSerialization.data(withJSONObject: json) else { return nil }
        return try? JSONDecoder().decode([String].self, from: data)
    }
    
    fileprivate static func getCustomView(from value: [String: Any]) -> Any? {
        value[CodingKeys.customView.rawValue]
    }
    
    fileprivate static func getDisableChatInput(from value: [String: Any]) -> Bool? {
        value[CodingKeys.disableChatInput.rawValue] as? Bool
    }
    
    fileprivate static func getTemplate(from value: [String: Any]) -> [String: Any]? {
        value[CodingKeys.template.rawValue] as? [String: Any]
    }
    
    fileprivate static func getUiSettings(from value: [String: Any]) -> SBUExtendedMessagePayloadForUI? {
        guard let json = value[CodingKeys.uiSettings.rawValue] else { return nil }
        guard let data = try? JSONSerialization.data(withJSONObject: json) else { return nil }
        return try? JSONDecoder().decode(SBUExtendedMessagePayloadForUI.self, from: data)
    }
}

extension SBUExtendedMessagePayload {
    func decodeCustomViewData<ViewData: Decodable>() throws -> ViewData? {
        guard let json = self.customView else { return nil }
        let data = try JSONSerialization.data(withJSONObject: json)
        return try JSONDecoder().decode(ViewData.self, from: data)
    }
}

extension Dictionary where Key == String, Value == Any {
    var toExtendedMessage: SBUExtendedMessagePayload? { SBUExtendedMessagePayload(from: self) }
    
    var toJsonString: String? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: []) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}
