//
//  CustomSampleManager.swift
//  SBUIKitTest-Swift5
//
//  Created by Tez Park on 4/24/24.
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import UIKit
#if !SWIFTUI
import SendbirdUIKit
#endif
import SendbirdChatSDK

// MARK: Common
class CustomSampleManager {
    /// (async) Gets the current user's latest group channel.
    @available(iOS 13.0, *)
    static func connectIfNeeded() async throws -> User {
        return try await withCheckedThrowingContinuation { continuation in
            SendbirdUI.connectIfNeeded { user, error in
                guard error == nil else {
                    print("Connect error. \(error!.localizedDescription)")
                    return
                }
                
                guard let user = user else {
                    print("No user.")
                    return
                }
                
                continuation.resume(returning: user)
            }
        }
    }
    
    // MARK: - Channels
    /// Gets the current user's latest group channel.
    static func getSampleGroupChannel(
        completionHandler: @escaping (_ channel: GroupChannel) -> Void
    ) {
        // Use an existing channel, if there is one.
        let params = GroupChannelListQueryParams()
        params.order = .latestLastMessage
        params.limit = 10
        params.includeEmptyChannel = true
        
        let channelListQuery = GroupChannel.createMyGroupChannelListQuery(params: params)
        channelListQuery.loadNextPage { channels, error in
            guard error == nil else {
                print("Group channel list query error. \(error!.localizedDescription)")
                return
            }
            
            if let channel = channels?.first {
                completionHandler(channel)
                return
            }
            
            // If there is no existing channel, create one.
            self.createGroupChannel(name: nil, isOperator: true) { channel, error in
                if let channel, error == nil {
                    completionHandler(channel)
                } else {
                    print("[Fail] Create group channel. \(error!.localizedDescription)")
                }
            }
        }
    }
    
    /// (async) Gets the current user's latest group channel.
    @available(iOS 13.0, *)
    static func getSampleGroupChannel() async throws -> GroupChannel {
        return try await withCheckedThrowingContinuation { continuation in
            self.getSampleGroupChannel { channel in
                continuation.resume(returning: channel)
            }
        }
    }
    
    /// Creates a group channel.
    private static func createGroupChannel(
        name: String?,
        isOperator: Bool,
        completionHandler: @escaping (GroupChannel?, SBError?) -> Void
    ) {
        let createParams = GroupChannelCreateParams()
        if let name { createParams.name = name }
        self.getUserIds { userIds, error in
            guard let userIds, error == nil else {
                completionHandler(nil, error!)
                return
            }
            
            createParams.userIds = userIds
            if isOperator, let currentUserId = SBUGlobals.currentUser?.userId {
                createParams.operatorUserIds = [currentUserId]
            }
            
            GroupChannel.createChannel(params: createParams) { channel, error in
                guard let channel, error == nil else {
                    completionHandler(nil, error!)
                    return
                }
                completionHandler(channel, nil)
            }
        }
    }
    
    /// Creates a group channel.
    @available(iOS 13.0, *)
    private static func createGroupChannel(
        name: String?,
        isOperator: Bool
    ) async throws -> GroupChannel {
        return try await withCheckedThrowingContinuation { continuation in
            self.createGroupChannel(name: name, isOperator: isOperator) { channel, error in
                guard let channel, error == nil else {
                    continuation.resume(throwing: error!)
                    return
                }
                continuation.resume(returning: channel)
            }
        }
    }
    
    /// Gets the current user's latest open channel.
    static func getSampleOpenChannel(
        completionHandler: @escaping (_ channel: OpenChannel) -> Void
    ) {
        // Use an existing channel, if there is one.
        let params = OpenChannelListQueryParams()
        params.limit = 10
        
        let channelListQuery = OpenChannel.createOpenChannelListQuery(params: params)
        channelListQuery.loadNextPage { channels, error in
            guard error == nil else {
                print("Open channel list query error. \(error!.localizedDescription)")
                return
            }
            
            if let channel = channels?.first {
                completionHandler(channel)
                return
            }
            
            // If there is no existing channel, create one.
            createOpenChannel(name: nil, isOperator: true) { channel, error in
                if let channel, error == nil {
                    completionHandler(channel)
                } else {
                    print("[Fail] Create group channel. \(error!.localizedDescription)")
                }
            }
        }
    }
    
    /// (sync) Gets the current user's latest open channel.
    @available(iOS 13.0, *)
    static func getSampleOpenChannel() async throws -> OpenChannel {
        return try await withCheckedThrowingContinuation { continuation in
            self.getSampleOpenChannel { channel in
                continuation.resume(returning: channel)
            }
        }
    }
    
    /// Creates an open channel.
    private static func createOpenChannel(
        name: String?,
        isOperator: Bool,
        completionHandler: @escaping (OpenChannel?, SBError?) -> Void
    ) {
        let createParams = OpenChannelCreateParams()
        if let name { createParams.name = name }
        if isOperator, let currentUserId = SBUGlobals.currentUser?.userId {
            createParams.operatorUserIds = [currentUserId]
        }
        
        OpenChannel.createChannel(params: createParams) { channel, error in
            guard let channel, error == nil else {
                completionHandler(nil, error!)
                return
            }
            completionHandler(channel, nil)
        }
    }
    
    /// Creates an open channel.
    @available(iOS 13.0, *)
    private static func createOpenChannel(
        name: String?,
        isOperator: Bool
    ) async throws -> OpenChannel {
        return try await withCheckedThrowingContinuation { continuation in
            self.createOpenChannel(name: name, isOperator: isOperator) { channel, error in
                if let channel, error == nil {
                    continuation.resume(returning: channel)
                } else {
                    continuation.resume(throwing: error!)
                }
            }
        }
    }
    
    // MARK: - Channels Where CurrentUser is Operator
    /// Gets a group channel where current user is operator.
    @available(iOS 13.0, *)
    static func getSampleGroupChannelOperator() async throws -> GroupChannel {
        // Use an existing group channel where current user is operator, if there is one.
        let params = GroupChannelListQueryParams()
        params.order = .latestLastMessage
        params.limit = 10
        params.includeEmptyChannel = true
        
        let channelListQuery = GroupChannel.createMyGroupChannelListQuery(params: params)
        
        if let channel = try await findOperatorGroupChannel(query: channelListQuery) {
            return channel
        }
        
        // Create new group channel.
        let channel = try await createGroupChannel(name: "HIHIHI", isOperator: true)
        return channel
    }
    
    /// Looks for an existing group channel where current user is the operator, and there is more than one member.
    /// If no such group channel is found, return nil.
    @available(iOS 13.0, *)
    private static func findOperatorGroupChannel(query: GroupChannelListQuery) async throws -> GroupChannel? {
        return try await withCheckedThrowingContinuation { continuation in
            query.loadNextPage { channels, error in
                guard let channels, error == nil else {
                    print("Group channel list query error. \(error!.localizedDescription)")
                    return
                }
                
                let operatorChannels = channels.filter {
                    $0.myRole == .operator // && $0.members.count > 1
                }
                if let channel = operatorChannels.first {
                    continuation.resume(returning: channel)
                    return
                }
                
                guard query.hasNext else {
                    continuation.resume(returning: nil)
                    return
                }
                
                Task {
                    do {
                        let result = try await findOperatorGroupChannel(query: query)
                        continuation.resume(returning: result)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                    
                }
            }
        }
    }
    
    /// Util method.
    /// Gets the user list of current app. (max 10, excludes current user)
    private static func getUserIds(completionHandler: @escaping ([String]?, SBError?) -> Void) {
        let query = SendbirdChat.createApplicationUserListQuery { params in
            params.limit = 10
        }
        
        query.loadNextPage { users, error in
            guard let users, error == nil else {
                print("[Fail] User list query error. \(error!)")
                completionHandler(nil, error!)
                return
            }
            
            let filteredUsers = users.filter { $0.userId != SBUGlobals.currentUser?.userId }
                                    .filter { !$0.userId.starts(with: "widget_") }
            let userIds = filteredUsers.map { $0.userId }
            completionHandler(userIds, nil)
        }
    }
    
    /// Util method.
    /// Gets the user list of current app. (max 10, excludes current user)
    @available(iOS 13.0, *)
    private static func getUserIds() async throws -> [String] {
        return try await withCheckedThrowingContinuation { continuation in
            self.getUserIds { userIds, error in
                guard let userIds, error == nil else {
                    continuation.resume(throwing: error!)
                    return
                }
                continuation.resume(returning: userIds)
            }
        }
    }
    
    /// Gets an open channel where current user is operator.
    @available(iOS 13.0, *)
    static func getSampleOpenChannelOperator() async throws -> OpenChannel? {
        // Use an existing open channel where currentUser is operator, if there is one.
        let params = OpenChannelListQueryParams()
        params.limit = 10
        let channelListQuery = OpenChannel.createOpenChannelListQuery(params: params)
        
        if let channel = try await findOperatorOpenChannel(query: channelListQuery) {
            return channel
        }
        
        // Create new open channel
        let channel = try await createOpenChannel(name: "Open", isOperator: true)
        return channel
    }
    
    /// Util method.
    /// Looks for an existing open channel where current user is the operator, and there is more than one participant.
    /// If no such open channel is found, return nil.
    @available(iOS 13.0, *)
    private static func findOperatorOpenChannel(query: OpenChannelListQuery) async throws -> OpenChannel? {
        return try await withCheckedThrowingContinuation { continuation in
            query.loadNextPage { channels, error in
                guard let channels, error == nil else {
                    print("[Fail] Open channel list query error. \(error!.localizedDescription)")
                    return
                }
                
                let operatorChannels = channels.filter { channel in
                    guard let userId = SBUGlobals.currentUser?.userId else { return false }
                    return channel.isOperator(userId: userId) && channel.participantCount > 1
                }
                if let channel = operatorChannels.first {
                    continuation.resume(returning: channel)
                    return
                }
                
                guard query.hasNext else {
                    continuation.resume(returning: nil)
                    return
                }
                
                Task {
                    do {
                        let result = try await findOperatorOpenChannel(query: query)
                        continuation.resume(returning: result)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                    
                }
            }
        }
    }
    
    // MARK: - MessageThread
    enum MessageType {
        case user
        case file
        case multipleFiles
        case webView
    }
    
    /// Gets the current user's latest group channel and thread parent message of type UserMessage.
    @available(iOS 13.0, *)
    static func getSampleMessageThreadUserMessage() async throws -> (channel: GroupChannel, parentMessage: UserMessage) {
        return try await withCheckedThrowingContinuation { continuation in
            self.getSampleMessageThread(messageType: .user) { channel, parentMessage, error in
                if let channel, let parentMessage = parentMessage as? UserMessage {
                    continuation.resume(returning: (channel, parentMessage))
                } else if let error {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    /// Gets the current user's latest group channel and thread parent message of type FileMessage.
    @available(iOS 13.0, *)
    static func getSampleMessageThreadFileMessage() async throws -> (channel: GroupChannel, parentMessage: FileMessage) {
        return try await withCheckedThrowingContinuation { continuation in
            self.getSampleMessageThread(messageType: .file) { channel, parentMessage, error in
                if let channel, let parentMessage = parentMessage as? FileMessage {
                    continuation.resume(returning: (channel, parentMessage))
                } else if let error {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    /// Gets the current user's latest group channel and thread parent message of type MultipleFilesMessage.
    @available(iOS 13.0, *)
    static func getSampleMessageThreadMultipleFilesMessage() async throws -> (channel: GroupChannel, parentMessage: MultipleFilesMessage) {
        return try await withCheckedThrowingContinuation { continuation in
            self.getSampleMessageThread(messageType: .multipleFiles) { channel, parentMessage, error in
                if let channel, let parentMessage = parentMessage as? MultipleFilesMessage {
                    continuation.resume(returning: (channel, parentMessage))
                } else if let error {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    /// Gets the current user's latest group channel and thread parent message of type UserMessage with a web link.
    @available(iOS 13.0, *)
    static func getSampleMessageThreadWebView() async throws -> (channel: GroupChannel, parentMessage: UserMessage) {
        return try await withCheckedThrowingContinuation { continuation in
            self.getSampleMessageThread(messageType: .webView) { channel, parentMessage, error in
                if let channel, let parentMessage = parentMessage as? UserMessage {
                    continuation.resume(returning: (channel, parentMessage))
                } else if let error {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    /// Gets a group channel and a parent message of indicated type.
    /// - Parameter messageType: the message type of parent message.
    static func getSampleMessageThread(
        messageType: MessageType,
        completionHandler: @escaping (_ channel: GroupChannel?, _ parentMessage: BaseMessage?, _ error: SBError?) -> Void
    ) {
        let params = GroupChannelListQueryParams()
        params.order = .latestLastMessage
        params.limit = 10
        params.includeEmptyChannel = true
        
        let channelListQuery = GroupChannel.createMyGroupChannelListQuery(params: params)
        channelListQuery.loadNextPage { channels, error in
            guard error == nil else {
                print("[Fail] Get a group channel for message thread. \(error!.localizedDescription)")
                completionHandler(nil, nil, error!)
                return
            }
            
            if let channel = channels?.first {
                createParentMessage(channel: channel, messageType: messageType)
            } else {
                createGroupChannel(name: "Thread", isOperator: true) { channel, error in
                    guard let channel, error == nil else {
                        completionHandler(nil, nil, error!)
                        return
                    }
                    createParentMessage(channel: channel, messageType: messageType)
                }
            }
            
            @Sendable func createParentMessage(channel: GroupChannel, messageType: MessageType) {
                switch messageType {
                case .user:
                    createParentUserMessage(channel: channel, completionHandler: completionHandler)
                case .file:
                    createParentFileMessage(channel: channel, completionHandler: completionHandler)
                case .multipleFiles:
                    createParentMultipleFilesMessage(channel: channel, completionHandler: completionHandler)
                case .webView:
                    createParentWebView(channel: channel, completionHandler: completionHandler)
                }
            }
        }
    }
    
    private static func createParentUserMessage(
        channel: GroupChannel,
        completionHandler: @escaping (_ channel: GroupChannel?, _ parentMessage: UserMessage?, _ error: SBError?) -> Void
    ) {
        if let lastMessage = channel.lastMessage as? UserMessage,
           lastMessage.parentMessage != nil {
            // Use an already created thread message
            completionHandler(channel, lastMessage, nil)
            return
        }
        
        // Create new parent message.
        channel.sendUserMessage("parent message") { message, error in
            guard let parentMessage = message, error == nil else {
                print("Send user message error. \(error!.localizedDescription)")
                completionHandler(nil, nil, error!)
                return
            }

            // Send a reply message to the parent message.
            let messageParams = UserMessageCreateParams(message: "reply message")
            messageParams.parentMessageId = parentMessage.messageId
            messageParams.isReplyToChannel = true
            
            channel.sendUserMessage(params: messageParams) { _, error in
                guard error == nil else {
                    print("Send thread message error. \(error!.localizedDescription)")
                    completionHandler(channel, parentMessage, error!)
                    return
                }
                
                completionHandler(channel, parentMessage, nil)
            }
        }
    }

    
    private static func createParentFileMessage(
        channel: GroupChannel,
        completionHandler: @escaping (_ channel: GroupChannel?, _ parentMessage: FileMessage?, _ error: SBError?) -> Void
    ) {
        if let lastMessage = channel.lastMessage,
           let parentMessage = lastMessage.parentMessage as? FileMessage {
            // Use an already created thread message
            completionHandler(channel, parentMessage, nil)
            return
        }
        
        // Create new parent message.
        let params = FileMessageCreateParams(fileURL: "https://picsum.photos/200/300")
        params.mimeType = "image/jpeg"
        channel.sendFileMessage(params: params) { message, error in
            guard let parentMessage = message, error == nil else {
                print("[Fail] send file message as parent message. \(error!.localizedDescription)")
                completionHandler(nil, nil, error!)
                return
            }
            
            // Send a reply message to the parent message.
            let replyMessageParams = UserMessageCreateParams(message: "reply message")
            replyMessageParams.parentMessageId = parentMessage.messageId
            replyMessageParams.isReplyToChannel = true
            
            channel.sendUserMessage(params: replyMessageParams) { _, error in
                guard error == nil else {
                    print("[Fail] reply to file message. \(error!.localizedDescription)")
                    completionHandler(channel, parentMessage, error!)
                    return
                }
                
                completionHandler(channel, parentMessage, nil)
            }
        }
    }
    
    private static func createParentMultipleFilesMessage(
        channel: GroupChannel,
        completionHandler: @escaping (_ channel: GroupChannel?, _ parentMessage: MultipleFilesMessage?, _ error: SBError?) -> Void
    ) {
        if let lastMessage = channel.lastMessage,
           let parentMessage = lastMessage.parentMessage as? MultipleFilesMessage {
            // Use an already created thread message
            completionHandler(channel, parentMessage, nil)
            return
        }
        
        // Create new parent message.
        let urlFile = UploadableFileInfo(fileURL: "https://picsum.photos/200/300")
        let fileList = [urlFile, urlFile, urlFile]
        let params = MultipleFilesMessageCreateParams(uploadableFileInfoList: fileList)
        
        channel.sendMultipleFilesMessage(
            params: params,
            fileUploadHandler: nil
        ) { message, error in
            guard let parentMessage = message, error == nil else {
                print("[Fail] send multiple files message as parent message. \(error!.localizedDescription)")
                completionHandler(nil, nil, error!)
                return
            }
            
            // Send a reply message to the parent message.
            let replyMessageParams = UserMessageCreateParams(message: "reply message")
            replyMessageParams.parentMessageId = parentMessage.messageId
            replyMessageParams.isReplyToChannel = true
            
            channel.sendUserMessage(params: replyMessageParams) { _, error in
                guard error == nil else {
                    print("[Fail] reply to file message. \(error!.localizedDescription)")
                    completionHandler(channel, parentMessage, error!)
                    return
                }
                
                completionHandler(channel, parentMessage, nil)
            }
        }
    }
    
    private static func createParentWebView(
        channel: GroupChannel,
        completionHandler: @escaping (_ channel: GroupChannel?, _ parentMessage: UserMessage?, _ error: SBError?) -> Void
    ) {
        if let lastMessage = channel.lastMessage,
           let parentMessage = lastMessage.parentMessage as? UserMessage {
            // Use an already created thread message
            completionHandler(channel, parentMessage, nil)
            return
        }
        
        // Create new parent message.
        channel.sendUserMessage("www.sendbird.com") { message, error in
            guard let parentMessage = message, error == nil else {
                print("[Fail] Send web view message error. \(error!.localizedDescription)")
                completionHandler(nil, nil, error!)
                return
            }

            // Send a reply message to the parent message.
            let messageParams = UserMessageCreateParams(message: "reply message")
            messageParams.parentMessageId = parentMessage.messageId
            messageParams.isReplyToChannel = true
            
            channel.sendUserMessage(params: messageParams) { _, error in
                guard error == nil else {
                    print("[Fail] Send thread message error. \(error!.localizedDescription)")
                    completionHandler(channel, parentMessage, error!)
                    return
                }
                
                completionHandler(channel, parentMessage, nil)
            }
        }
    }
}
