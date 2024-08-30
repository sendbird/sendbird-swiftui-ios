//
//  DefaultViewConfigSet.swift
//  SendbirdSwiftUI
//
//  Created by Tez Park on 7/3/24.
//

import Foundation
import SendbirdChatSDK

struct DefaultViewConfigSet {
    // TODO: SwiftUI - 구조 정리
    static let groupChannel: SendbirdChatSDK.GroupChannel = SendbirdChatSDK.GroupChannel.make(["channel_url": "channel_url", "created_at": 1234567890])!
    static let openChannel: SendbirdChatSDK.OpenChannel = SendbirdChatSDK.OpenChannel.make(["channel_url": "channel_url", "created_at": 1234567890])!
    static let baseMessage: SendbirdChatSDK.BaseMessage = SendbirdChatSDK.BaseMessage.make(["message": "base message", "message_id": 1234567890])!
    
    static let adminMessage: SendbirdChatSDK.AdminMessage = SendbirdChatSDK.AdminMessage.make(["message": "admin message"])!
    static let userMessage: SendbirdChatSDK.UserMessage = SendbirdChatSDK.UserMessage.make(["message": "user message"])!
    static let fileMessage: SendbirdChatSDK.FileMessage = SendbirdChatSDK.FileMessage.make(["message": "file message"])!
    static var multipleFilesMessage: SendbirdChatSDK.MultipleFilesMessage = SendbirdChatSDK.MultipleFilesMessage.make(["files": Array(repeating: [:], count: 2)])!
    static var ogMetaData: SendbirdChatSDK.OGMetaData = SendbirdChatSDK.OGMetaData.make([:])!
    
    static let channelCoverImageSize = CGSize(width: 34.0, height: 34.0)
    static let coverImagePrefix = "https://static.sendbird.com/sample/cover"
    
    static var typingMessage: SBUTypingIndicatorMessage = SBUTypingIndicatorMessage.make(["": ""])!
    static var typingInfo: SBUTypingIndicatorInfo = SBUTypingIndicatorInfo(typers: [], numberOfTypers: 0)
    static var groupChannelPushTriggerOption: SendbirdChatSDK.GroupChannelPushTriggerOption = .all
}

extension DefaultViewConfigSet {
    
    static let scrollBottomButtonSize = CGSize(width: 38.0, height: 38.0)
    
    static let sbuUser = SBUUser(userId: "")
    static let userCellHeight: CGFloat = 40
    static let userCellMoreButtonWidth: CGFloat = 24
    static let userCellMorebuttonSize = CGSize(width: 24, height: 24)
    static let userCellCheckBoxSize = CGSize(width: 24, height: 24)
    static let userCellCoverImageSize = CGSize(width: 40, height: 40)
    static let userCellProfileImageSize = CGSize(width: 40, height: 40)

    static let groupSettingsRowHeight: CGFloat = 31
    
    static let sender = Sender.make([:])!
    
    struct Open {
        struct Channel {
            static let senderProfileImage: CGSize = .init(width: 26, height: 26)
            static let textMaxWidth: CGFloat = SBUConstant.messageCellMaxWidth
            static let thumbnailSize: CGSize = SBUConstant.openChannelThumbnailSize
            static let coverImageSize: CGFloat = 34.0
            static let stateBannerHeight: CGFloat = 24.0
        }
    }
    
    struct Group {
        struct Channel {
            static let senderProfileImage: CGSize = .init(width: 26, height: 26)
            static let textMaxWidth: CGFloat = SBUConstant.messageCellMaxWidth
            static let thumbnailSize: CGSize = SBUConstant.thumbnailSize
            static let coverImageSize: CGFloat = 34.0
            static let typingBubbleSize: CGSize = CGSize(width: 60.0, height: 34.0)
            static let stateBannerHeight: CGFloat = 24.0
        }
        
        struct Thread {
            struct ParentInfoView {
                static let multipleFilesThumbnailSize: CGSize = SBUConstant.parentInfoMultipleFilesThumbnailSize
            }
            static let stateBannerHeight: CGFloat = 24.0
        }
    }
    
    struct GroupChannelList {
        static let coverImageSize = CGSize(width: 56.0, height: 56.0)
        static let badgeHeight: CGFloat = 20 // unreadCount
    }
    
    struct GroupChannel {
        struct Input {
            static let buttonSize: CGSize = CGSize(width: 32, height: 38)
        }
    }
    
    struct OpenChannelList {
        static let coverImageSize = CGSize(width: 56.0, height: 56.0)
        static let badgeHeight: CGFloat = 16
    }
    
    struct OpenChannel {
        struct Input {
            static let buttonSize: CGSize = CGSize(width: 32, height: 38)
        }
    }
    
    struct MessageThread {
        struct Input {
            static let buttonSize: CGSize = CGSize(width: 32, height: 38)
        }
        static let stateBannerHeight: CGFloat = 24.0
    }
}
