//
//  SBUTheme.Deprecated.swift
//  SendbirdUIKit
//
//  Created by Jaesung Lee on 2022/10/25.
//  Copyright © 2022 Sendbird, Inc. All rights reserved.
//

import UIKit

@available(*, deprecated, renamed: "SBUGroupChannelListTheme") // 3.2.2
public typealias SBUChannelListTheme = SBUGroupChannelListTheme

@available(*, deprecated, renamed: "SBUGroupChannelCellTheme") // 3.2.2
public typealias SBUChannelCellTheme = SBUGroupChannelCellTheme

extension SBUTheme {
    @available(*, deprecated, renamed: "init(groupChannelListTheme:groupChannelCellTheme:openChannelListTheme:openChannelCellTheme:channelTheme:messageInputTheme:messageCellTheme:userListTheme:userCellTheme:channelSettingsTheme:userProfileTheme:componentTheme:overlayTheme:messageSearchTheme:messageSearchResultCellTheme:createOpenChannelTheme:)") // 3.2.2
    public convenience init(channelListTheme: SBUGroupChannelListTheme,
                            channelCellTheme: SBUGroupChannelCellTheme,
                            openChannelListTheme: SBUOpenChannelListTheme = .light,
                            openChannelCellTheme: SBUOpenChannelCellTheme = .light,
                            channelTheme: SBUChannelTheme = .light,
                            messageInputTheme: SBUMessageInputTheme = .light,
                            messageCellTheme: SBUMessageCellTheme = .light,
                            userListTheme: SBUUserListTheme = .light,
                            userCellTheme: SBUUserCellTheme = .light,
                            channelSettingsTheme: SBUChannelSettingsTheme = .light,
                            userProfileTheme: SBUUserProfileTheme = .light,
                            componentTheme: SBUComponentTheme = .light,
                            overlayTheme: SBUOverlayTheme = .init(),
                            messageSearchTheme: SBUMessageSearchTheme = .light,
                            messageSearchResultCellTheme: SBUMessageSearchResultCellTheme = .light,
                            createOpenChannelTheme: SBUCreateOpenChannelTheme = .light
    ) {
        self.init(
            groupChannelListTheme: channelListTheme,
            groupChannelCellTheme: channelCellTheme,
            openChannelListTheme: openChannelListTheme,
            openChannelCellTheme: openChannelCellTheme,
            channelTheme: channelTheme,
            messageInputTheme: messageInputTheme,
            messageCellTheme: messageCellTheme,
            userListTheme: userListTheme,
            userCellTheme: userCellTheme,
            channelSettingsTheme: channelSettingsTheme,
            userProfileTheme: userProfileTheme,
            componentTheme: componentTheme,
            overlayTheme: overlayTheme,
            messageSearchTheme: messageSearchTheme,
            messageSearchResultCellTheme: messageSearchResultCellTheme,
            createOpenChannelTheme: createOpenChannelTheme
        )
    }
    
    @available(*, deprecated, renamed: "setGroupChannelList(channelListTheme:channelCellTheme:)") // 3.2.2
    public static func setChannelList(
        channelListTheme: SBUGroupChannelListTheme,
        channelCellTheme: SBUGroupChannelCellTheme
    ) {
        setGroupChannelList(
            channelListTheme: channelListTheme,
            channelCellTheme: channelCellTheme
        )
    }
    
    @available(*, deprecated, renamed: "groupChannelListTheme") // 3.2.2
    public static var channelListTheme: SBUGroupChannelListTheme {
        set { groupChannelListTheme = newValue }
        get { groupChannelListTheme }
    }
    
    @available(*, deprecated, renamed: "groupChannelCellTheme") // 3.2.2
    public static var channelCellTheme: SBUGroupChannelCellTheme {
        set { groupChannelCellTheme = newValue }
        get { groupChannelCellTheme }
    }
}

extension SBUMessageCellTheme {
    @available(*, deprecated, renamed: "unknownMessageDescLeftTextColor") // 3.2.2
    public var unknownMessageDescTextColor: UIColor {
        unknownMessageDescLeftTextColor
    }
    
    @available(*, deprecated, renamed: "init(backgroundColor:leftBackgroundColor:leftPressedBackgroundColor:rightBackgroundColor:rightPressedBackgroundColor:openChannelBackgroundColor:openChannelPressedBackgroundColor:dateFont:dateTextColor:dateBackgroundColor:userPlaceholderBackgroundColor:userPlaceholderTintColor:userNameFont:userNameTextColor:currentUserNameTextColor:timeFont:timeTextColor:pendingStateColor:failedStateColor:succeededStateColor:readReceiptStateColor:deliveryReceiptStateColor:userMessageFont:userMessageLeftTextColor:userMessageLeftEditTextColor:userMessageLeftHighlightTextColor:userMessageRightTextColor:userMessageRightEditTextColor:userMessageRightHighlightTextColor:fileIconBackgroundColor:fileImageBackgroundColor:fileImageIconColor:fileIconColor:fileMessageNameFont:fileMessageLeftTextColor:fileMessageRightTextColor:fileMessagePlaceholderColor:adminMessageFont:adminMessageTextColor:unknownMessageDescFont:unknownMessageDescTextColor:unknownMessageDescRightTextColor:ogTitleFont:ogTitleColor:ogDescriptionFont:ogDescriptionColor:ogURLAddressFont:ogURLAddressColor:openChannelOGTitleColor:linkColor:contentBackgroundColor:pressedContentBackgroundColor:quotedMessageBackgroundColor:quotedFileMessageThumbnailColor:quotedMessageTextColor:quotedMessageTextFont:repliedIconColor:repliedToTextColor:repliedToTextFont:mentionTextFont:mentionLeftTextColor:mentionRightTextColor:mentionLeftTextBackgroundColor:mentionRightTextBackgroundColor:buttonBackgroundColor:buttonTitleColor:sideButtonIconColor:newMessageBadgeColor:)") // 3.2.2
    public convenience init(
        backgroundColor: UIColor = SBUColorSet.background50,
        leftBackgroundColor: UIColor = SBUColorSet.background100,
        leftPressedBackgroundColor: UIColor = SBUColorSet.primaryExtraLight,
        rightBackgroundColor: UIColor = SBUColorSet.primaryMain,
        rightPressedBackgroundColor: UIColor = SBUColorSet.primaryDark,
        openChannelBackgroundColor: UIColor = .clear,
        openChannelPressedBackgroundColor: UIColor = SBUColorSet.background100,
        dateFont: UIFont = SBUFontSet.caption1,
        dateTextColor: UIColor = SBUColorSet.onDarkTextHighEmphasis,
        dateBackgroundColor: UIColor = SBUColorSet.overlayLight,
        userPlaceholderBackgroundColor: UIColor = SBUColorSet.background300,
        userPlaceholderTintColor: UIColor = SBUColorSet.onDarkTextHighEmphasis,
        userNameFont: UIFont = SBUFontSet.caption1,
        userNameTextColor: UIColor = SBUColorSet.onLightTextMidEmphasis,
        currentUserNameTextColor: UIColor = SBUColorSet.secondaryMain,
        timeFont: UIFont = SBUFontSet.caption4,
        timeTextColor: UIColor = SBUColorSet.onLightTextLowEmphasis,
        pendingStateColor: UIColor = SBUColorSet.primaryMain,
        failedStateColor: UIColor = SBUColorSet.errorMain,
        succeededStateColor: UIColor = SBUColorSet.onLightTextLowEmphasis,
        readReceiptStateColor: UIColor = SBUColorSet.secondaryMain,
        deliveryReceiptStateColor: UIColor = SBUColorSet.onLightTextLowEmphasis,
        userMessageFont: UIFont = SBUFontSet.body3,
        userMessageLeftTextColor: UIColor = SBUColorSet.onLightTextHighEmphasis,
        userMessageLeftEditTextColor: UIColor = SBUColorSet.onLightTextMidEmphasis,
        userMessageLeftHighlightTextColor: UIColor = SBUColorSet.onLightTextHighEmphasis,
        userMessageRightTextColor: UIColor = SBUColorSet.onDarkTextHighEmphasis,
        userMessageRightEditTextColor: UIColor = SBUColorSet.onDarkTextMidEmphasis,
        userMessageRightHighlightTextColor: UIColor = SBUColorSet.onLightTextHighEmphasis,
        fileIconBackgroundColor: UIColor = SBUColorSet.background50,
        fileImageBackgroundColor: UIColor = SBUColorSet.onDarkTextHighEmphasis,
        fileImageIconColor: UIColor = SBUColorSet.onLightTextMidEmphasis,
        fileIconColor: UIColor = SBUColorSet.primaryMain,
        fileMessageNameFont: UIFont = SBUFontSet.body3,
        fileMessageLeftTextColor: UIColor = SBUColorSet.onLightTextHighEmphasis,
        fileMessageRightTextColor: UIColor = SBUColorSet.onDarkTextHighEmphasis,
        fileMessagePlaceholderColor: UIColor = SBUColorSet.onLightTextMidEmphasis,
        adminMessageFont: UIFont = SBUFontSet.caption2,
        adminMessageTextColor: UIColor = SBUColorSet.onLightTextMidEmphasis,
        unknownMessageDescFont: UIFont  = SBUFontSet.body3,
        unknownMessageDescTextColor: UIColor = SBUColorSet.onLightTextMidEmphasis,
        unknownMessageDescRightTextColor: UIColor = SBUColorSet.onDarkTextMidEmphasis,
        ogTitleFont: UIFont = SBUFontSet.body2,
        ogTitleColor: UIColor = SBUColorSet.onLightTextHighEmphasis,
        ogDescriptionFont: UIFont = SBUFontSet.caption2,
        ogDescriptionColor: UIColor  = SBUColorSet.onLightTextHighEmphasis,
        ogURLAddressFont: UIFont = SBUFontSet.caption2,
        ogURLAddressColor: UIColor = SBUColorSet.onLightTextMidEmphasis,
        openChannelOGTitleColor: UIColor = SBUColorSet.primaryMain,
        linkColor: UIColor = SBUColorSet.primaryMain,
        contentBackgroundColor: UIColor = SBUColorSet.background100,
        pressedContentBackgroundColor: UIColor = SBUColorSet.background300,
        quotedMessageBackgroundColor: UIColor,
        quotedFileMessageThumbnailColor: UIColor = SBUColorSet.onLightTextMidEmphasis,
        quotedMessageTextColor: UIColor = SBUColorSet.onLightTextLowEmphasis,
        quotedMessageTextFont: UIFont = SBUFontSet.body3,
        repliedIconColor: UIColor = SBUColorSet.onLightTextLowEmphasis,
        repliedToTextColor: UIColor = SBUColorSet.onLightTextLowEmphasis,
        repliedToTextFont: UIFont = SBUFontSet.caption1,
        mentionTextFont: UIFont = SBUFontSet.body4,
        mentionLeftTextColor: UIColor = SBUColorSet.onLightTextHighEmphasis,
        mentionRightTextColor: UIColor = SBUColorSet.onDarkTextHighEmphasis,
        mentionLeftTextBackgroundColor: UIColor = .clear,
        mentionRightTextBackgroundColor: UIColor = .clear,
        buttonBackgroundColor: UIColor = SBUColorSet.background200,
        buttonTitleColor: UIColor = SBUColorSet.primaryMain,
        sideButtonIconColor: UIColor = SBUColorSet.onLightTextLowEmphasis,
        newMessageBadgeColor: UIColor = SBUColorSet.secondaryMain
    ) {
        self.init(
            backgroundColor: backgroundColor,
            leftBackgroundColor: leftBackgroundColor,
            leftPressedBackgroundColor: leftPressedBackgroundColor,
            rightBackgroundColor: rightBackgroundColor,
            rightPressedBackgroundColor: rightPressedBackgroundColor,
            openChannelBackgroundColor: openChannelBackgroundColor,
            openChannelPressedBackgroundColor: openChannelPressedBackgroundColor,
            dateFont: dateFont,
            dateTextColor: dateTextColor,
            dateBackgroundColor: dateBackgroundColor,
            userPlaceholderBackgroundColor: userPlaceholderBackgroundColor,
            userPlaceholderTintColor: userPlaceholderTintColor,
            userNameFont: userNameFont,
            userNameTextColor: userNameTextColor,
            currentUserNameTextColor: currentUserNameTextColor,
            timeFont: timeFont,
            timeTextColor: timeTextColor,
            pendingStateColor: pendingStateColor,
            failedStateColor: failedStateColor,
            succeededStateColor: succeededStateColor,
            readReceiptStateColor: readReceiptStateColor,
            deliveryReceiptStateColor: deliveryReceiptStateColor,
            userMessageFont: userMessageFont,
            userMessageLeftTextColor: userMessageLeftTextColor,
            userMessageLeftEditTextColor: userMessageLeftEditTextColor,
            userMessageLeftHighlightTextColor: userMessageLeftHighlightTextColor,
            userMessageRightTextColor: userMessageRightTextColor,
            userMessageRightEditTextColor: userMessageRightEditTextColor,
            userMessageRightHighlightTextColor: userMessageRightHighlightTextColor,
            fileIconBackgroundColor: fileIconBackgroundColor,
            fileImageBackgroundColor: fileImageBackgroundColor,
            fileImageIconColor: fileImageIconColor,
            fileIconColor: fileIconColor,
            fileMessageNameFont: fileMessageNameFont,
            fileMessageLeftTextColor: fileMessageLeftTextColor,
            fileMessageRightTextColor: fileMessageRightTextColor,
            fileMessagePlaceholderColor: fileMessagePlaceholderColor,
            adminMessageFont: adminMessageFont,
            adminMessageTextColor: adminMessageTextColor,
            unknownMessageDescFont: unknownMessageDescFont,
            unknownMessageDescLeftTextColor: unknownMessageDescTextColor,
            unknownMessageDescRightTextColor: unknownMessageDescRightTextColor,
            ogTitleFont: ogTitleFont,
            ogTitleColor: ogTitleColor,
            ogDescriptionFont: ogDescriptionFont,
            ogDescriptionColor: ogDescriptionColor,
            ogURLAddressFont: ogURLAddressFont,
            ogURLAddressColor: ogURLAddressColor,
            openChannelOGTitleColor: openChannelOGTitleColor,
            linkColor: linkColor,
            contentBackgroundColor: contentBackgroundColor,
            pressedContentBackgroundColor: pressedContentBackgroundColor,
            quotedMessageLeftBackgroundColor: quotedMessageBackgroundColor.withAlphaComponent(0.5),
            quotedMessageRightBackgroundColor: quotedMessageBackgroundColor,
            quotedFileMessageThumbnailColor: quotedFileMessageThumbnailColor,
            quotedMessageTextColor: quotedMessageTextColor,
            quotedMessageTextFont: quotedMessageTextFont,
            repliedIconColor: repliedIconColor,
            repliedToTextColor: repliedToTextColor,
            repliedToTextFont: repliedToTextFont,
            mentionTextFont: mentionTextFont,
            mentionLeftTextColor: mentionLeftTextColor,
            mentionRightTextColor: mentionRightTextColor,
            mentionLeftTextBackgroundColor: mentionLeftTextBackgroundColor,
            mentionRightTextBackgroundColor: mentionRightTextBackgroundColor,
            buttonBackgroundColor: buttonBackgroundColor,
            buttonTitleColor: buttonTitleColor,
            sideButtonIconColor: sideButtonIconColor,
            newMessageBadgeColor: newMessageBadgeColor
        )
    }
    
    @available(*, deprecated, renamed: "init(backgroundColor:leftBackgroundColor:leftPressedBackgroundColor:rightBackgroundColor:rightPressedBackgroundColor:openChannelBackgroundColor:openChannelPressedBackgroundColor:dateFont:dateTextColor:dateBackgroundColor:userPlaceholderBackgroundColor:userPlaceholderTintColor:userNameFont:userNameTextColor:currentUserNameTextColor:timeFont:timeTextColor:pendingStateColor:failedStateColor:succeededStateColor:readReceiptStateColor:deliveryReceiptStateColor:userMessageFont:userMessageLeftTextColor:userMessageLeftEditTextColor:userMessageLeftHighlightTextColor:userMessageRightTextColor:userMessageRightEditTextColor:userMessageRightHighlightTextColor:fileIconBackgroundColor:fileImageBackgroundColor:fileImageIconColor:fileIconColor:fileMessageNameFont:fileMessageLeftTextColor:fileMessageRightTextColor:fileMessagePlaceholderColor:adminMessageFont:adminMessageTextColor:unknownMessageDescFont:unknownMessageDescLeftTextColor:unknownMessageDescRightTextColor:ogTitleFont:ogTitleColor:ogDescriptionFont:ogDescriptionColor:ogURLAddressFont:ogURLAddressColor:openChannelOGTitleColor:linkColor:contentBackgroundColor:pressedContentBackgroundColor:quotedMessageLeftBackgroundColor:quotedMessageRightBackgroundColor:quotedFileMessageThumbnailColor:quotedMessageTextColor:quotedMessageTextFont:repliedIconColor:repliedToTextColor:repliedToTextFont:repliedCountTextColor:repliedCountTextFont:repliedUsersMoreIconBackgroundColor:repliedUsersMoreIconTintColor:mentionTextFont:mentionLeftTextColor:mentionRightTextColor:mentionLeftTextBackgroundColor:mentionRightTextBackgroundColor:buttonBackgroundColor:buttonTitleColor:sideButtonIconColor:newMessageBadgeColor:parentInfoBackgroundColor:parentInfoUserNameTextFont:parentInfoUserNameTextColor:parentInfoDateFont:parentInfoDateTextColor:parentInfoMoreButtonTintColor:parentInfoSeparateBarColor:parentInfoReplyCountTextColor:parentInfoReplyCountTextFont:parentInfoProgressBackgroundColor:progressTrackTintColor:progressTimeFont:progressTimeRightTextColor:progressTimeLeftTextColor:statusButtonBackgroundColor:loadingButtonTintColor:playButtonTintColor:pauseButtonTintColor:)") // [NXET_VERSION]
    public convenience init(backgroundColor: UIColor = SBUColorSet.background50,
                leftBackgroundColor: UIColor = SBUColorSet.background100,
                leftPressedBackgroundColor: UIColor = SBUColorSet.primaryExtraLight,
                rightBackgroundColor: UIColor = SBUColorSet.primaryMain,
                rightPressedBackgroundColor: UIColor = SBUColorSet.primaryDark,
                openChannelBackgroundColor: UIColor = .clear,
                openChannelPressedBackgroundColor: UIColor = SBUColorSet.background100,
                dateFont: UIFont = SBUFontSet.caption1,
                dateTextColor: UIColor = SBUColorSet.onDarkTextHighEmphasis,
                dateBackgroundColor: UIColor = SBUColorSet.overlayLight,
                userPlaceholderBackgroundColor: UIColor = SBUColorSet.background300,
                userPlaceholderTintColor: UIColor = SBUColorSet.onDarkTextHighEmphasis,
                userNameFont: UIFont = SBUFontSet.caption1,
                userNameTextColor: UIColor = SBUColorSet.onLightTextMidEmphasis,
                currentUserNameTextColor: UIColor = SBUColorSet.secondaryMain,
                timeFont: UIFont = SBUFontSet.caption4,
                timeTextColor: UIColor = SBUColorSet.onLightTextLowEmphasis,
                pendingStateColor: UIColor = SBUColorSet.primaryMain,
                failedStateColor: UIColor = SBUColorSet.errorMain,
                succeededStateColor: UIColor = SBUColorSet.onLightTextLowEmphasis,
                readReceiptStateColor: UIColor = SBUColorSet.secondaryMain,
                deliveryReceiptStateColor: UIColor = SBUColorSet.onLightTextLowEmphasis,
                userMessageFont: UIFont = SBUFontSet.body3,
                userMessageLeftTextColor: UIColor = SBUColorSet.onLightTextHighEmphasis,
                userMessageLeftEditTextColor: UIColor = SBUColorSet.onLightTextMidEmphasis,
                userMessageLeftHighlightTextColor: UIColor = SBUColorSet.onLightTextHighEmphasis,
                userMessageRightTextColor: UIColor = SBUColorSet.onDarkTextHighEmphasis,
                userMessageRightEditTextColor: UIColor = SBUColorSet.onDarkTextMidEmphasis,
                userMessageRightHighlightTextColor: UIColor = SBUColorSet.onLightTextHighEmphasis,
                fileIconBackgroundColor: UIColor = SBUColorSet.background50,
                fileImageBackgroundColor: UIColor = SBUColorSet.onDarkTextHighEmphasis,
                fileImageIconColor: UIColor = SBUColorSet.onLightTextMidEmphasis,
                fileIconColor: UIColor = SBUColorSet.primaryMain,
                fileMessageNameFont: UIFont = SBUFontSet.body3,
                fileMessageLeftTextColor: UIColor = SBUColorSet.onLightTextHighEmphasis,
                fileMessageRightTextColor: UIColor = SBUColorSet.onDarkTextHighEmphasis,
                fileMessagePlaceholderColor: UIColor = SBUColorSet.onLightTextMidEmphasis,
                adminMessageFont: UIFont = SBUFontSet.caption2,
                adminMessageTextColor: UIColor = SBUColorSet.onLightTextMidEmphasis,
                unknownMessageDescFont: UIFont  = SBUFontSet.body3,
                unknownMessageDescLeftTextColor: UIColor = SBUColorSet.onLightTextMidEmphasis,
                unknownMessageDescRightTextColor: UIColor = SBUColorSet.onDarkTextMidEmphasis,
                ogTitleFont: UIFont = SBUFontSet.body2,
                ogTitleColor: UIColor = SBUColorSet.onLightTextHighEmphasis,
                ogDescriptionFont: UIFont = SBUFontSet.caption2,
                ogDescriptionColor: UIColor  = SBUColorSet.onLightTextHighEmphasis,
                ogURLAddressFont: UIFont = SBUFontSet.caption2,
                ogURLAddressColor: UIColor = SBUColorSet.onLightTextMidEmphasis,
                openChannelOGTitleColor: UIColor = SBUColorSet.primaryMain,
                linkColor: UIColor = SBUColorSet.primaryMain,
                contentBackgroundColor: UIColor = SBUColorSet.background100,
                pressedContentBackgroundColor: UIColor = SBUColorSet.background300,
                quotedMessageBackgroundColor: UIColor,
                quotedFileMessageThumbnailColor: UIColor = SBUColorSet.onLightTextMidEmphasis,
                quotedMessageTextColor: UIColor = SBUColorSet.onLightTextLowEmphasis,
                quotedMessageTextFont: UIFont = SBUFontSet.body3,
                repliedIconColor: UIColor = SBUColorSet.onLightTextLowEmphasis,
                repliedToTextColor: UIColor = SBUColorSet.onLightTextLowEmphasis,
                repliedToTextFont: UIFont = SBUFontSet.caption1,
                repliedCountTextColor: UIColor = SBUColorSet.primaryMain,
                repliedCountTextFont: UIFont = SBUFontSet.caption3,
                repliedUsersMoreIconBackgroundColor: UIColor = SBUColorSet.background700.withAlphaComponent(0.64),
                repliedUsersMoreIconTintColor: UIColor = SBUColorSet.onDarkTextHighEmphasis,
                mentionTextFont: UIFont = SBUFontSet.body4,
                mentionLeftTextColor: UIColor = SBUColorSet.onLightTextHighEmphasis,
                mentionRightTextColor: UIColor = SBUColorSet.onDarkTextHighEmphasis,
                mentionLeftTextBackgroundColor: UIColor = .clear,
                mentionRightTextBackgroundColor: UIColor = .clear,
                buttonBackgroundColor: UIColor = SBUColorSet.background200,
                buttonTitleColor: UIColor = SBUColorSet.primaryMain,
                sideButtonIconColor: UIColor = SBUColorSet.onLightTextLowEmphasis,
                newMessageBadgeColor: UIColor = SBUColorSet.secondaryMain,
                parentInfoBackgroundColor: UIColor = SBUColorSet.background50,
                parentInfoUserNameTextFont: UIFont = SBUFontSet.h3,
                parentInfoUserNameTextColor: UIColor = SBUColorSet.onLightTextHighEmphasis,
                parentInfoDateFont: UIFont = SBUFontSet.caption2,
                parentInfoDateTextColor: UIColor = SBUColorSet.onLightTextLowEmphasis,
                parentInfoMoreButtonTintColor: UIColor = SBUColorSet.onLightTextMidEmphasis,
                parentInfoSeparateBarColor: UIColor = SBUColorSet.onLightTextDisabled,
                parentInfoReplyCountTextColor: UIColor = SBUColorSet.onLightTextLowEmphasis,
                parentInfoReplyCountTextFont: UIFont = SBUFontSet.body3,
                parentInfoProgressBackgroundColor: UIColor = SBUColorSet.background100,
                progressTrackTintColor: UIColor = SBUColorSet.onLightTextLowEmphasis,
                progressTimeFont: UIFont = SBUFontSet.body3,
                progressTimeRightTextColor: UIColor = SBUColorSet.onDarkTextHighEmphasis,
                progressTimeLeftTextColor: UIColor = SBUColorSet.onLightTextHighEmphasis,
                statusButtonBackgroundColor: UIColor = SBUColorSet.background50,
                loadingButtonTintColor: UIColor = SBUColorSet.primaryLight,
                playButtonTintColor: UIColor = SBUColorSet.primaryMain,
                pauseButtonTintColor: UIColor = SBUColorSet.primaryMain
    ) {
        self.init(
            backgroundColor: backgroundColor,
            leftBackgroundColor: leftBackgroundColor,
            leftPressedBackgroundColor: leftPressedBackgroundColor,
            rightBackgroundColor: rightBackgroundColor,
            rightPressedBackgroundColor: rightPressedBackgroundColor,
            openChannelBackgroundColor: openChannelBackgroundColor,
            openChannelPressedBackgroundColor: openChannelPressedBackgroundColor,
            dateFont: dateFont,
            dateTextColor: dateTextColor,
            dateBackgroundColor: dateBackgroundColor,
            userPlaceholderBackgroundColor: userPlaceholderBackgroundColor,
            userPlaceholderTintColor: userPlaceholderTintColor,
            userNameFont: userNameFont,
            userNameTextColor: userNameTextColor,
            currentUserNameTextColor: currentUserNameTextColor,
            timeFont: timeFont,
            timeTextColor: timeTextColor,
            pendingStateColor: pendingStateColor,
            failedStateColor: failedStateColor,
            succeededStateColor: succeededStateColor,
            readReceiptStateColor: readReceiptStateColor,
            deliveryReceiptStateColor: deliveryReceiptStateColor,
            userMessageFont: userMessageFont,
            userMessageLeftTextColor: userMessageLeftTextColor,
            userMessageLeftEditTextColor: userMessageLeftEditTextColor,
            userMessageLeftHighlightTextColor: userMessageLeftHighlightTextColor,
            userMessageRightTextColor: userMessageRightTextColor,
            userMessageRightEditTextColor: userMessageRightEditTextColor,
            userMessageRightHighlightTextColor: userMessageRightHighlightTextColor,
            fileIconBackgroundColor: fileIconBackgroundColor,
            fileImageBackgroundColor: fileImageBackgroundColor,
            fileImageIconColor: fileImageIconColor,
            fileIconColor: fileIconColor,
            fileMessageNameFont: fileMessageNameFont,
            fileMessageLeftTextColor: fileMessageLeftTextColor,
            fileMessageRightTextColor: fileMessageRightTextColor,
            fileMessagePlaceholderColor: fileMessagePlaceholderColor,
            adminMessageFont: adminMessageFont,
            adminMessageTextColor: adminMessageTextColor,
            unknownMessageDescFont: unknownMessageDescFont,
            unknownMessageDescLeftTextColor: unknownMessageDescLeftTextColor,
            unknownMessageDescRightTextColor: unknownMessageDescRightTextColor,
            ogTitleFont: ogTitleFont,
            ogTitleColor: ogTitleColor,
            ogDescriptionFont: ogDescriptionFont,
            ogDescriptionColor: ogDescriptionColor,
            ogURLAddressFont: ogURLAddressFont,
            ogURLAddressColor: ogURLAddressColor,
            openChannelOGTitleColor: openChannelOGTitleColor,
            linkColor: linkColor,
            contentBackgroundColor: contentBackgroundColor,
            pressedContentBackgroundColor: pressedContentBackgroundColor,
            quotedMessageLeftBackgroundColor: quotedMessageBackgroundColor.withAlphaComponent(0.5),
            quotedMessageRightBackgroundColor: quotedMessageBackgroundColor,
            quotedFileMessageThumbnailColor: quotedFileMessageThumbnailColor,
            quotedMessageTextColor: quotedMessageTextColor,
            quotedMessageTextFont: quotedMessageTextFont,
            repliedIconColor: repliedIconColor,
            repliedToTextColor: repliedToTextColor,
            repliedToTextFont: repliedToTextFont,
            mentionTextFont: mentionTextFont,
            mentionLeftTextColor: mentionLeftTextColor,
            mentionRightTextColor: mentionRightTextColor,
            mentionLeftTextBackgroundColor: mentionLeftTextBackgroundColor,
            mentionRightTextBackgroundColor: mentionRightTextBackgroundColor,
            buttonBackgroundColor: buttonBackgroundColor,
            buttonTitleColor: buttonTitleColor,
            sideButtonIconColor: sideButtonIconColor,
            newMessageBadgeColor: newMessageBadgeColor
        )
    }
}
