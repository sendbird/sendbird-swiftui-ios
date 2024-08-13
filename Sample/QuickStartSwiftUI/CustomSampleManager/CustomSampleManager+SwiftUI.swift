
// MARK: SwiftUI
import SwiftUI
import SendbirdChatSDK

#if SWIFTUI
extension CustomSampleManager {
    @ViewBuilder
    static func viewForName(_ viewItem: CustomSampleInfo.ViewItem) -> some View {
        switch viewItem.viewFullPath {
		case "CustomTheme.ColorSet.Custom.Main":
            CustomTheme.ColorSet.Custom.Main()
		case "CustomTheme.FontSet.Custom.Main":
            CustomTheme.FontSet.Custom.Main()
		case "CustomTheme.IconSet.Custom.Main":
            CustomTheme.IconSet.Custom.Main()
		case "CustomTheme.Theme.Custom.Main":
            CustomTheme.Theme.Custom.Main()
		case "CustomGroupChannelList.SwiftUI.View.Main":
            CustomGroupChannelList.SwiftUI.View.Main()
		case "CustomGroupChannelList.SwiftUI.View.CustomMain":
            CustomGroupChannelList.SwiftUI.View.CustomMain()
		case "CustomGroupChannelList.SubView.Builder.groupChannel":
            CustomGroupChannelList.SubView.Builder.groupChannel()
		case "CustomGroupChannelList.SubView.Builder.createChannel":
            CustomGroupChannelList.SubView.Builder.createChannel()
		case "CustomGroupChannelList.ViewConverter.Header.leftView":
            CustomGroupChannelList.ViewConverter.Header.leftView()
		case "CustomGroupChannelList.ViewConverter.Header.rightView":
            CustomGroupChannelList.ViewConverter.Header.rightView()
		case "CustomGroupChannelList.ViewConverter.Header.titleView":
            CustomGroupChannelList.ViewConverter.Header.titleView()
		case "CustomGroupChannelList.ViewConverter.List.entireView":
            CustomGroupChannelList.ViewConverter.List.entireView()
		case "CustomGroupChannelList.ViewConverter.List.rowView":
            CustomGroupChannelList.ViewConverter.List.rowView()
		case "CustomGroupChannelList.ViewConverter.List.coverImage":
            CustomGroupChannelList.ViewConverter.List.coverImage()
		case "CustomGroupChannelList.ViewConverter.List.channelName":
            CustomGroupChannelList.ViewConverter.List.channelName()
		case "CustomGroupChannelList.ViewConverter.List.channelPreview":
            CustomGroupChannelList.ViewConverter.List.channelPreview()
		case "CustomGroupChannelList.ViewConverter.List.unreadCount":
            CustomGroupChannelList.ViewConverter.List.unreadCount()
		case "CustomOpenChannelList.SwiftUI.View.Main":
            CustomOpenChannelList.SwiftUI.View.Main()
		case "CustomOpenChannelList.SwiftUI.View.CustomMain":
            CustomOpenChannelList.SwiftUI.View.CustomMain()
		case "CustomOpenChannelList.SubView.Builder.openChannel":
            CustomOpenChannelList.SubView.Builder.openChannel()
		case "CustomOpenChannelList.SubView.Builder.createChannel":
            CustomOpenChannelList.SubView.Builder.createChannel()
		case "CustomOpenChannelList.ViewConverter.Header.leftView":
            CustomOpenChannelList.ViewConverter.Header.leftView()
		case "CustomOpenChannelList.ViewConverter.Header.rightView":
            CustomOpenChannelList.ViewConverter.Header.rightView()
		case "CustomOpenChannelList.ViewConverter.Header.titleView":
            CustomOpenChannelList.ViewConverter.Header.titleView()
		case "CustomOpenChannelList.ViewConverter.List.entireView":
            CustomOpenChannelList.ViewConverter.List.entireView()
		case "CustomOpenChannelList.ViewConverter.List.rowView":
            CustomOpenChannelList.ViewConverter.List.rowView()
		case "CustomOpenChannelList.ViewConverter.List.coverImage":
            CustomOpenChannelList.ViewConverter.List.coverImage()
		case "CustomOpenChannelList.ViewConverter.List.channelName":
            CustomOpenChannelList.ViewConverter.List.channelName()
		case "CustomOpenChannelList.ViewConverter.List.channelPreview":
            CustomOpenChannelList.ViewConverter.List.channelPreview()
		case "CustomGroupChannel.SwiftUI.View.Main":
            CustomGroupChannel.SwiftUI.View.Main()
		case "CustomGroupChannel.SwiftUI.View.CustomMain":
            CustomGroupChannel.SwiftUI.View.CustomMain()
		case "CustomGroupChannel.SubView.Builder.channelSettings":
            CustomGroupChannel.SubView.Builder.channelSettings()
		case "CustomGroupChannel.SubView.Builder.messageThread":
            CustomGroupChannel.SubView.Builder.messageThread()
		case "CustomGroupChannel.ViewConverter.Header.leftView":
            CustomGroupChannel.ViewConverter.Header.leftView()
		case "CustomGroupChannel.ViewConverter.Header.rightView":
            CustomGroupChannel.ViewConverter.Header.rightView()
		case "CustomGroupChannel.ViewConverter.Header.titleView":
            CustomGroupChannel.ViewConverter.Header.titleView()
		case "CustomGroupChannel.ViewConverter.Header.coverImage":
            CustomGroupChannel.ViewConverter.Header.coverImage()
		case "CustomGroupChannel.ViewConverter.Header.titleLabel":
            CustomGroupChannel.ViewConverter.Header.titleLabel()
		case "CustomGroupChannel.ViewConverter.Header.typingStatusView":
            CustomGroupChannel.ViewConverter.Header.typingStatusView()
		case "CustomGroupChannel.ViewConverter.List.entireView":
            CustomGroupChannel.ViewConverter.List.entireView()
		case "CustomGroupChannel.ViewConverter.List.rowView":
            CustomGroupChannel.ViewConverter.List.rowView()
		case "CustomGroupChannel.ViewConverter.List.senderProfileImage":
            CustomGroupChannel.ViewConverter.List.senderProfileImage()
		case "CustomGroupChannel.ViewConverter.List.userMessageView":
            CustomGroupChannel.ViewConverter.List.userMessageView()
		case "CustomGroupChannel.ViewConverter.List.fileMessageView":
            CustomGroupChannel.ViewConverter.List.fileMessageView()
		case "CustomGroupChannel.ViewConverter.List.multipleFilesMessageView":
            CustomGroupChannel.ViewConverter.List.multipleFilesMessageView()
		case "CustomGroupChannel.ViewConverter.List.adminMessageView":
            CustomGroupChannel.ViewConverter.List.adminMessageView()
		case "CustomGroupChannel.ViewConverter.List.typingIndicatorView":
            CustomGroupChannel.ViewConverter.List.typingIndicatorView()
		case "CustomGroupChannel.ViewConverter.List.newMessageInfoView":
            CustomGroupChannel.ViewConverter.List.newMessageInfoView()
		case "CustomGroupChannel.ViewConverter.List.scrollBottomView":
            CustomGroupChannel.ViewConverter.List.scrollBottomView()
		case "CustomGroupChannel.ViewConverter.List.channelStateBanner":
            CustomGroupChannel.ViewConverter.List.channelStateBanner()
		case "CustomGroupChannel.ViewConverter.Input.entireView":
            CustomGroupChannel.ViewConverter.Input.entireView()
		case "CustomGroupChannel.ViewConverter.Input.leftView":
            CustomGroupChannel.ViewConverter.Input.leftView()
		case "CustomGroupChannel.ViewConverter.Input.addButton":
            CustomGroupChannel.ViewConverter.Input.addButton()
		case "CustomGroupChannel.ViewConverter.Input.rightView":
            CustomGroupChannel.ViewConverter.Input.rightView()
		case "CustomGroupChannel.ViewConverter.Input.sendButton":
            CustomGroupChannel.ViewConverter.Input.sendButton()
		case "CustomGroupChannel.ViewConverter.Input.voiceButton":
            CustomGroupChannel.ViewConverter.Input.voiceButton()
		case "CustomOpenChannel.SwiftUI.View.Main":
            CustomOpenChannel.SwiftUI.View.Main()
		case "CustomOpenChannel.SwiftUI.View.CustomMain":
            CustomOpenChannel.SwiftUI.View.CustomMain()
		case "CustomOpenChannel.SubView.Builder.channelSettings":
            CustomOpenChannel.SubView.Builder.channelSettings()
		case "CustomOpenChannel.SubView.Builder.participantList":
            CustomOpenChannel.SubView.Builder.userList()
		case "CustomOpenChannel.ViewConverter.Header.leftView":
            CustomOpenChannel.ViewConverter.Header.leftView()
		case "CustomOpenChannel.ViewConverter.Header.rightView":
            CustomOpenChannel.ViewConverter.Header.rightView()
		case "CustomOpenChannel.ViewConverter.Header.titleView":
            CustomOpenChannel.ViewConverter.Header.titleView()
		case "CustomOpenChannel.ViewConverter.Header.coverImage":
            CustomOpenChannel.ViewConverter.Header.coverImage()
		case "CustomOpenChannel.ViewConverter.Header.titleLabel":
            CustomOpenChannel.ViewConverter.Header.titleLabel()
		case "CustomOpenChannel.ViewConverter.Header.subtitleLabel":
            CustomOpenChannel.ViewConverter.Header.subtitleLabel()
		case "CustomOpenChannel.ViewConverter.List.entireView":
            CustomOpenChannel.ViewConverter.List.entireView()
		case "CustomOpenChannel.ViewConverter.List.rowView":
            CustomOpenChannel.ViewConverter.List.rowView()
		case "CustomOpenChannel.ViewConverter.List.senderProfileImage":
            CustomOpenChannel.ViewConverter.List.senderProfileImage()
		case "CustomOpenChannel.ViewConverter.List.userMessageView":
            CustomOpenChannel.ViewConverter.List.userMessageView()
		case "CustomOpenChannel.ViewConverter.List.fileMessageView":
            CustomOpenChannel.ViewConverter.List.fileMessageView()
		case "CustomOpenChannel.ViewConverter.List.adminMessageView":
            CustomOpenChannel.ViewConverter.List.adminMessageView()
		case "CustomOpenChannel.ViewConverter.List.scrollBottomView":
            CustomOpenChannel.ViewConverter.List.scrollBottomView()
		case "CustomOpenChannel.ViewConverter.Media.entireView":
            CustomOpenChannel.ViewConverter.Media.entireView()
		case "CustomOpenChannel.ViewConverter.Input.entireView":
            CustomOpenChannel.ViewConverter.Input.entireView()
		case "CustomOpenChannel.ViewConverter.Input.leftView":
            CustomOpenChannel.ViewConverter.Input.leftView()
		case "CustomOpenChannel.ViewConverter.Input.addButton":
            CustomOpenChannel.ViewConverter.Input.addButton()
		case "CustomOpenChannel.ViewConverter.Input.rightView":
            CustomOpenChannel.ViewConverter.Input.rightView()
		case "CustomOpenChannel.ViewConverter.Input.sendButton":
            CustomOpenChannel.ViewConverter.Input.sendButton()
		case "CustomCreateGroupChannel.SwiftUI.View.Main":
            CustomCreateGroupChannel.SwiftUI.View.Main()
		case "CustomCreateGroupChannel.SwiftUI.View.CustomMain":
            CustomCreateGroupChannel.SwiftUI.View.CustomMain()
		case "CustomCreateGroupChannel.ViewConverter.Header.leftView":
            CustomCreateGroupChannel.ViewConverter.Header.leftView()
		case "CustomCreateGroupChannel.ViewConverter.Header.rightView":
            CustomCreateGroupChannel.ViewConverter.Header.rightView()
		case "CustomCreateGroupChannel.ViewConverter.Header.titleView":
            CustomCreateGroupChannel.ViewConverter.Header.titleView()
		case "CustomCreateGroupChannel.ViewConverter.List.entireView":
            CustomCreateGroupChannel.ViewConverter.List.entireView()
		case "CustomCreateGroupChannel.ViewConverter.List.rowView":
            CustomCreateGroupChannel.ViewConverter.List.rowView()
		case "CustomCreateGroupChannel.ViewConverter.List.profileImage":
            CustomCreateGroupChannel.ViewConverter.List.profileImage()
		case "CustomCreateGroupChannel.ViewConverter.List.userNameLabel":
            CustomCreateGroupChannel.ViewConverter.List.userNameLabel()
		case "CustomCreateGroupChannel.ViewConverter.List.selectionButton":
            CustomCreateGroupChannel.ViewConverter.List.selectionButton()
		case "CustomCreateOpenChannel.SwiftUI.View.Main":
            CustomCreateOpenChannel.SwiftUI.View.Main()
		case "CustomCreateOpenChannel.SwiftUI.View.CustomMain":
            CustomCreateOpenChannel.SwiftUI.View.CustomMain()
		case "CustomCreateOpenChannel.ViewConverter.Header.leftView":
            CustomCreateOpenChannel.ViewConverter.Header.leftView()
		case "CustomCreateOpenChannel.ViewConverter.Header.rightView":
            CustomCreateOpenChannel.ViewConverter.Header.rightView()
		case "CustomCreateOpenChannel.ViewConverter.Header.titleView":
            CustomCreateOpenChannel.ViewConverter.Header.titleView()
		case "CustomCreateOpenChannel.ViewConverter.List.entireView":
            CustomCreateOpenChannel.ViewConverter.List.entireView()
		case "CustomCreateOpenChannel.ViewConverter.List.rowView":
            CustomCreateOpenChannel.ViewConverter.List.rowView()
		case "CustomCreateOpenChannel.ViewConverter.List.profileImage":
            CustomCreateOpenChannel.ViewConverter.List.profileImage()
		case "CustomCreateOpenChannel.ViewConverter.List.userNameLabel":
            CustomCreateOpenChannel.ViewConverter.List.userNameLabel()
		case "CustomCreateOpenChannel.ViewConverter.List.selectionButton":
            CustomCreateOpenChannel.ViewConverter.List.selectionButton()
		case "CustomInviteUser.SwiftUI.View.Main":
            CustomInviteUser.SwiftUI.View.Main()
		case "CustomInviteUser.SwiftUI.View.CustomMain":
            CustomInviteUser.SwiftUI.View.CustomMain()
		case "CustomInviteUser.ViewConverter.Header.leftView":
            CustomInviteUser.ViewConverter.Header.leftView()
		case "CustomInviteUser.ViewConverter.Header.rightView":
            CustomInviteUser.ViewConverter.Header.rightView()
		case "CustomInviteUser.ViewConverter.Header.titleView":
            CustomInviteUser.ViewConverter.Header.titleView()
		case "CustomInviteUser.ViewConverter.List.entireView":
            CustomInviteUser.ViewConverter.List.entireView()
		case "CustomInviteUser.ViewConverter.List.rowView":
            CustomInviteUser.ViewConverter.List.rowView()
		case "CustomInviteUser.ViewConverter.List.profileImage":
            CustomInviteUser.ViewConverter.List.profileImage()
		case "CustomInviteUser.ViewConverter.List.userNameLabel":
            CustomInviteUser.ViewConverter.List.userNameLabel()
		case "CustomInviteUser.ViewConverter.List.selectionButton":
            CustomInviteUser.ViewConverter.List.selectionButton()
		case "CustomGroupChannelRegisterOperator.SwiftUI.View.Main":
            CustomGroupChannelRegisterOperator.SwiftUI.View.Main()
		case "CustomGroupChannelRegisterOperator.SwiftUI.View.CustomMain":
            CustomGroupChannelRegisterOperator.SwiftUI.View.CustomMain()
		case "CustomGroupChannelRegisterOperator.ViewConverter.Header.leftView":
            CustomGroupChannelRegisterOperator.ViewConverter.Header.leftView()
		case "CustomGroupChannelRegisterOperator.ViewConverter.Header.rightView":
            CustomGroupChannelRegisterOperator.ViewConverter.Header.rightView()
		case "CustomGroupChannelRegisterOperator.ViewConverter.Header.titleView":
            CustomGroupChannelRegisterOperator.ViewConverter.Header.titleView()
		case "CustomGroupChannelRegisterOperator.ViewConverter.List.entireView":
            CustomGroupChannelRegisterOperator.ViewConverter.List.entireView()
		case "CustomOpenChannelRegisterOperator.SwiftUI.View.Main":
            CustomOpenChannelRegisterOperator.SwiftUI.View.Main()
		case "CustomOpenChannelRegisterOperator.SwiftUI.View.CustomMain":
            CustomOpenChannelRegisterOperator.SwiftUI.View.CustomMain()
		case "CustomOpenChannelRegisterOperator.ViewConverter.Header.leftView":
            CustomOpenChannelRegisterOperator.ViewConverter.Header.leftView()
		case "CustomOpenChannelRegisterOperator.ViewConverter.Header.rightView":
            CustomOpenChannelRegisterOperator.ViewConverter.Header.rightView()
		case "CustomOpenChannelRegisterOperator.ViewConverter.Header.titleView":
            CustomOpenChannelRegisterOperator.ViewConverter.Header.titleView()
		case "CustomOpenChannelRegisterOperator.ViewConverter.List.entireView":
            CustomOpenChannelRegisterOperator.ViewConverter.List.entireView()
		case "CustomGroupMemberList.SwiftUI.View.Main":
            CustomGroupMemberList.SwiftUI.View.Main()
		case "CustomGroupMemberList.SwiftUI.View.CustomMain":
            CustomGroupMemberList.SwiftUI.View.CustomMain()
		case "CustomGroupMemberList.SubView.Builder.inviteUser":
            CustomGroupMemberList.SubView.Builder.inviteUser()
		case "CustomGroupMemberList.ViewConverter.Header.leftView":
            CustomGroupMemberList.ViewConverter.Header.leftView()
		case "CustomGroupMemberList.ViewConverter.Header.rightView":
            CustomGroupMemberList.ViewConverter.Header.rightView()
		case "CustomGroupMemberList.ViewConverter.Header.titleView":
            CustomGroupMemberList.ViewConverter.Header.titleView()
		case "CustomGroupMemberList.ViewConverter.List.entireView":
            CustomGroupMemberList.ViewConverter.List.entireView()
		case "CustomGroupMemberList.ViewConverter.List.rowView":
            CustomGroupMemberList.ViewConverter.List.rowView()
		case "CustomGroupMemberList.ViewConverter.List.profileImage":
            CustomGroupMemberList.ViewConverter.List.profileImage()
		case "CustomGroupMemberList.ViewConverter.List.userNameLabel":
            CustomGroupMemberList.ViewConverter.List.userNameLabel()
		case "CustomGroupMemberList.ViewConverter.List.operatorStateView":
            CustomGroupMemberList.ViewConverter.List.operatorStateView()
		case "CustomGroupMemberList.ViewConverter.List.moreButton":
            CustomGroupMemberList.ViewConverter.List.moreButton()
		case "CustomOpenParticipantList.SwiftUI.View.Main":
            CustomOpenParticipantList.SwiftUI.View.Main()
		case "CustomOpenParticipantList.SwiftUI.View.CustomMain":
            CustomOpenParticipantList.SwiftUI.View.CustomMain()
		case "CustomOpenParticipantList.ViewConverter.Header.leftView":
            CustomOpenParticipantList.ViewConverter.Header.leftView()
		case "CustomOpenParticipantList.ViewConverter.Header.rightView":
            CustomOpenParticipantList.ViewConverter.Header.rightView()
		case "CustomOpenParticipantList.ViewConverter.Header.titleView":
            CustomOpenParticipantList.ViewConverter.Header.titleView()
		case "CustomOpenParticipantList.ViewConverter.List.entireView":
            CustomOpenParticipantList.ViewConverter.List.entireView()
		case "CustomOpenParticipantList.ViewConverter.List.rowView":
            CustomOpenParticipantList.ViewConverter.List.rowView()
		case "CustomOpenParticipantList.ViewConverter.List.profileImage":
            CustomOpenParticipantList.ViewConverter.List.profileImage()
		case "CustomOpenParticipantList.ViewConverter.List.userNameLabel":
            CustomOpenParticipantList.ViewConverter.List.userNameLabel()
		case "CustomOpenParticipantList.ViewConverter.List.operatorStateView":
            CustomOpenParticipantList.ViewConverter.List.operatorStateView()
		case "CustomOpenParticipantList.ViewConverter.List.moreButton":
            CustomOpenParticipantList.ViewConverter.List.moreButton()
		case "CustomGroupChannelPushSettings.SwiftUI.View.Main":
            CustomGroupChannelPushSettings.SwiftUI.View.Main()
		case "CustomGroupChannelPushSettings.SwiftUI.View.CustomMain":
            CustomGroupChannelPushSettings.SwiftUI.View.CustomMain()
		case "CustomGroupChannelPushSettings.ViewConverter.Header.leftView":
            CustomGroupChannelPushSettings.ViewConverter.Header.leftView()
		case "CustomGroupChannelPushSettings.ViewConverter.Header.rightView":
            CustomGroupChannelPushSettings.ViewConverter.Header.rightView()
		case "CustomGroupChannelPushSettings.ViewConverter.Header.titleView":
            CustomGroupChannelPushSettings.ViewConverter.Header.titleView()
		case "CustomGroupChannelPushSettings.ViewConverter.List.entireView":
            CustomGroupChannelPushSettings.ViewConverter.List.entireView()
		case "CustomGroupChannelSettings.SwiftUI.View.Main":
            CustomGroupChannelSettings.SwiftUI.View.Main()
		case "CustomGroupChannelSettings.SwiftUI.View.CustomMain":
            CustomGroupChannelSettings.SwiftUI.View.CustomMain()
		case "CustomGroupChannelSettings.SubView.Builder.memberList":
            CustomGroupChannelSettings.SubView.Builder.userList()
		case "CustomGroupChannelSettings.SubView.Builder.moderations":
            CustomGroupChannelSettings.SubView.Builder.moderations()
		case "CustomGroupChannelSettings.SubView.Builder.pushSettings":
            CustomGroupChannelSettings.SubView.Builder.pushSettings()
		case "CustomGroupChannelSettings.ViewConverter.Header.leftView":
            CustomGroupChannelSettings.ViewConverter.Header.leftView()
		case "CustomGroupChannelSettings.ViewConverter.Header.rightView":
            CustomGroupChannelSettings.ViewConverter.Header.rightView()
		case "CustomGroupChannelSettings.ViewConverter.Header.titleView":
            CustomGroupChannelSettings.ViewConverter.Header.titleView()
		case "CustomGroupChannelSettings.ViewConverter.List.entireView":
            CustomGroupChannelSettings.ViewConverter.List.entireView()
		case "CustomGroupChannelSettings.ViewConverter.List.channelInfo":
            CustomGroupChannelSettings.ViewConverter.List.channelInfo()
		case "CustomGroupChannelSettings.ViewConverter.List.moderation":
            CustomGroupChannelSettings.ViewConverter.List.moderation()
		case "CustomGroupChannelSettings.ViewConverter.List.notification":
            CustomGroupChannelSettings.ViewConverter.List.notification()
		case "CustomGroupChannelSettings.ViewConverter.List.member":
            CustomGroupChannelSettings.ViewConverter.List.member()
		case "CustomGroupChannelSettings.ViewConverter.List.searchItem":
            CustomGroupChannelSettings.ViewConverter.List.searchItem()
		case "CustomGroupChannelSettings.ViewConverter.List.leaveChannel":
            CustomGroupChannelSettings.ViewConverter.List.leaveChannel()
		case "CustomOpenChannelSettings.SwiftUI.View.Main":
            CustomOpenChannelSettings.SwiftUI.View.Main()
		case "CustomOpenChannelSettings.SwiftUI.View.CustomMain":
            CustomOpenChannelSettings.SwiftUI.View.CustomMain()
		case "CustomOpenChannelSettings.SubView.Builder.participantList":
            CustomOpenChannelSettings.SubView.Builder.userList()
		case "CustomOpenChannelSettings.SubView.Builder.moderations":
            CustomOpenChannelSettings.SubView.Builder.moderations()
		case "CustomOpenChannelSettings.ViewConverter.Header.leftView":
            CustomOpenChannelSettings.ViewConverter.Header.leftView()
		case "CustomOpenChannelSettings.ViewConverter.Header.rightView":
            CustomOpenChannelSettings.ViewConverter.Header.rightView()
		case "CustomOpenChannelSettings.ViewConverter.Header.titleView":
            CustomOpenChannelSettings.ViewConverter.Header.titleView()
		case "CustomOpenChannelSettings.ViewConverter.List.entireView":
            CustomOpenChannelSettings.ViewConverter.List.entireView()
		case "CustomGroupModerations.SwiftUI.View.Main":
            CustomGroupModerations.SwiftUI.View.Main()
		case "CustomGroupModerations.SwiftUI.View.CustomMain":
            CustomGroupModerations.SwiftUI.View.CustomMain()
		case "CustomGroupModerations.ViewConverter.Header.leftView":
            CustomGroupModerations.ViewConverter.Header.leftView()
		case "CustomGroupModerations.ViewConverter.Header.rightView":
            CustomGroupModerations.ViewConverter.Header.rightView()
		case "CustomGroupModerations.ViewConverter.Header.titleView":
            CustomGroupModerations.ViewConverter.Header.titleView()
		case "CustomGroupModerations.ViewConverter.List.entireView":
            CustomGroupModerations.ViewConverter.List.entireView()
		case "CustomOpenModerations.SwiftUI.View.Main":
            CustomOpenModerations.SwiftUI.View.Main()
		case "CustomOpenModerations.SwiftUI.View.CustomMain":
            CustomOpenModerations.SwiftUI.View.CustomMain()
		case "CustomOpenModerations.ViewConverter.Header.leftView":
            CustomOpenModerations.ViewConverter.Header.leftView()
		case "CustomOpenModerations.ViewConverter.Header.rightView":
            CustomOpenModerations.ViewConverter.Header.rightView()
		case "CustomOpenModerations.ViewConverter.Header.titleView":
            CustomOpenModerations.ViewConverter.Header.titleView()
		case "CustomOpenModerations.ViewConverter.List.entireView":
            CustomOpenModerations.ViewConverter.List.entireView()
		case "CustomMessageSearch.SwiftUI.View.Main":
            CustomMessageSearch.SwiftUI.View.Main()
		case "CustomMessageSearch.SwiftUI.View.CustomMain":
            CustomMessageSearch.SwiftUI.View.CustomMain()
		case "CustomMessageSearch.SubView.Builder.groupChannel":
            CustomMessageSearch.SubView.Builder.groupChannel()
		case "CustomMessageSearch.ViewConverter.Header.leftView":
            CustomMessageSearch.ViewConverter.Header.leftView()
		case "CustomMessageSearch.ViewConverter.Header.rightView":
            CustomMessageSearch.ViewConverter.Header.rightView()
		case "CustomMessageSearch.ViewConverter.Header.titleView":
            CustomMessageSearch.ViewConverter.Header.titleView()
		case "CustomMessageSearch.ViewConverter.List.entireView":
            CustomMessageSearch.ViewConverter.List.entireView()
		case "CustomMessageThread.SwiftUI.View.Main":
            CustomMessageThread.SwiftUI.View.Main()
		case "CustomMessageThread.SwiftUI.View.CustomMain":
            CustomMessageThread.SwiftUI.View.CustomMain()
		case "CustomMessageThread.ViewConverter.Header.leftView":
            CustomMessageThread.ViewConverter.Header.leftView()
		case "CustomMessageThread.ViewConverter.Header.rightView":
            CustomMessageThread.ViewConverter.Header.rightView()
		case "CustomMessageThread.ViewConverter.Header.titleView":
            CustomMessageThread.ViewConverter.Header.titleView()
		case "CustomMessageThread.ViewConverter.Header.titleLabel":
            CustomMessageThread.ViewConverter.Header.titleLabel()
		case "CustomMessageThread.ViewConverter.Header.subtitleLabel":
            CustomMessageThread.ViewConverter.Header.subtitleLabel()
		case "CustomMessageThread.ViewConverter.List.entireView":
            CustomMessageThread.ViewConverter.List.entireView()
		case "CustomMessageThread.ViewConverter.List.rowView":
            CustomMessageThread.ViewConverter.List.rowView()
		case "CustomMessageThread.ViewConverter.List.senderProfileImage":
            CustomMessageThread.ViewConverter.List.senderProfileImage()
		case "CustomMessageThread.ViewConverter.List.userMessageView":
            CustomMessageThread.ViewConverter.List.userMessageView()
		case "CustomMessageThread.ViewConverter.List.fileMessageView":
            CustomMessageThread.ViewConverter.List.fileMessageView()
		case "CustomMessageThread.ViewConverter.List.multipleFilesMessageView":
            CustomMessageThread.ViewConverter.List.multipleFilesMessageView()
		case "CustomMessageThread.ViewConverter.List.channelStateBanner":
            CustomMessageThread.ViewConverter.List.channelStateBanner()
		case "CustomMessageThread.ViewConverter.ParentInfo.entireContent":
            CustomMessageThread.ViewConverter.ParentInfo.entireContent()
		case "CustomMessageThread.ViewConverter.ParentInfo.profileView":
            CustomMessageThread.ViewConverter.ParentInfo.profileView()
		case "CustomMessageThread.ViewConverter.ParentInfo.userNameLabel":
            CustomMessageThread.ViewConverter.ParentInfo.userNameLabel()
		case "CustomMessageThread.ViewConverter.ParentInfo.dateLabel":
            CustomMessageThread.ViewConverter.ParentInfo.dateLabel()
		case "CustomMessageThread.ViewConverter.ParentInfo.moreButton":
            CustomMessageThread.ViewConverter.ParentInfo.moreButton()
		case "CustomMessageThread.ViewConverter.ParentInfo.replyLabel":
            CustomMessageThread.ViewConverter.ParentInfo.replyLabel()
		case "CustomMessageThread.ViewConverter.ParentInfo.messageTextView":
            CustomMessageThread.ViewConverter.ParentInfo.messageTextView()
		case "CustomMessageThread.ViewConverter.ParentInfo.fileContentView":
            CustomMessageThread.ViewConverter.ParentInfo.fileContentView()
		case "CustomMessageThread.ViewConverter.ParentInfo.multipleFileContentView":
            CustomMessageThread.ViewConverter.ParentInfo.multipleFileContentView()
		case "CustomMessageThread.ViewConverter.ParentInfo.webView":
            CustomMessageThread.ViewConverter.ParentInfo.webView()
		case "CustomMessageThread.ViewConverter.ParentInfo.reactionView":
            CustomMessageThread.ViewConverter.ParentInfo.reactionView()
		case "CustomMessageThread.ViewConverter.Input.entireView":
            CustomMessageThread.ViewConverter.Input.entireView()
		case "CustomMessageThread.ViewConverter.Input.leftView":
            CustomMessageThread.ViewConverter.Input.leftView()
		case "CustomMessageThread.ViewConverter.Input.addButton":
            CustomMessageThread.ViewConverter.Input.addButton()
		case "CustomMessageThread.ViewConverter.Input.rightView":
            CustomMessageThread.ViewConverter.Input.rightView()
		case "CustomMessageThread.ViewConverter.Input.sendButton":
            CustomMessageThread.ViewConverter.Input.sendButton()
		case "CustomMessageThread.ViewConverter.Input.voiceButton":
            CustomMessageThread.ViewConverter.Input.voiceButton()
		case "CustomGroupMutedMemberList.SwiftUI.View.Main":
            CustomGroupMutedMemberList.SwiftUI.View.Main()
		case "CustomGroupMutedMemberList.SwiftUI.View.CustomMain":
            CustomGroupMutedMemberList.SwiftUI.View.CustomMain()
		case "CustomGroupMutedMemberList.ViewConverter.Header.leftView":
            CustomGroupMutedMemberList.ViewConverter.Header.leftView()
		case "CustomGroupMutedMemberList.ViewConverter.Header.rightView":
            CustomGroupMutedMemberList.ViewConverter.Header.rightView()
		case "CustomGroupMutedMemberList.ViewConverter.Header.titleView":
            CustomGroupMutedMemberList.ViewConverter.Header.titleView()
		case "CustomGroupMutedMemberList.ViewConverter.List.entireView":
            CustomGroupMutedMemberList.ViewConverter.List.entireView()
		case "CustomGroupMutedMemberList.ViewConverter.List.rowView":
            CustomGroupMutedMemberList.ViewConverter.List.rowView()
		case "CustomGroupMutedMemberList.ViewConverter.List.profileImage":
            CustomGroupMutedMemberList.ViewConverter.List.profileImage()
		case "CustomGroupMutedMemberList.ViewConverter.List.userNameLabel":
            CustomGroupMutedMemberList.ViewConverter.List.userNameLabel()
		case "CustomGroupMutedMemberList.ViewConverter.List.operatorStateView":
            CustomGroupMutedMemberList.ViewConverter.List.operatorStateView()
		case "CustomGroupMutedMemberList.ViewConverter.List.moreButton":
            CustomGroupMutedMemberList.ViewConverter.List.moreButton()
		case "CustomGroupBannedUserList.SwiftUI.View.Main":
            CustomGroupBannedUserList.SwiftUI.View.Main()
		case "CustomGroupBannedUserList.SwiftUI.View.CustomMain":
            CustomGroupBannedUserList.SwiftUI.View.CustomMain()
		case "CustomGroupBannedUserList.ViewConverter.Header.leftView":
            CustomGroupBannedUserList.ViewConverter.Header.leftView()
		case "CustomGroupBannedUserList.ViewConverter.Header.rightView":
            CustomGroupBannedUserList.ViewConverter.Header.rightView()
		case "CustomGroupBannedUserList.ViewConverter.Header.titleView":
            CustomGroupBannedUserList.ViewConverter.Header.titleView()
		case "CustomGroupBannedUserList.ViewConverter.List.entireView":
            CustomGroupBannedUserList.ViewConverter.List.entireView()
		case "CustomGroupBannedUserList.ViewConverter.List.rowView":
            CustomGroupBannedUserList.ViewConverter.List.rowView()
		case "CustomGroupBannedUserList.ViewConverter.List.profileImage":
            CustomGroupBannedUserList.ViewConverter.List.profileImage()
		case "CustomGroupBannedUserList.ViewConverter.List.userNameLabel":
            CustomGroupBannedUserList.ViewConverter.List.userNameLabel()
		case "CustomGroupBannedUserList.ViewConverter.List.moreButton":
            CustomGroupBannedUserList.ViewConverter.List.moreButton()
		case "CustomGroupOperatorList.SwiftUI.View.Main":
            CustomGroupOperatorList.SwiftUI.View.Main()
		case "CustomGroupOperatorList.SwiftUI.View.CustomMain":
            CustomGroupOperatorList.SwiftUI.View.CustomMain()
		case "CustomGroupOperatorList.SubView.Builder.registerOperator":
            CustomGroupOperatorList.SubView.Builder.registerOperator()
		case "CustomGroupOperatorList.ViewConverter.Header.leftView":
            CustomGroupOperatorList.ViewConverter.Header.leftView()
		case "CustomGroupOperatorList.ViewConverter.Header.rightView":
            CustomGroupOperatorList.ViewConverter.Header.rightView()
		case "CustomGroupOperatorList.ViewConverter.Header.titleView":
            CustomGroupOperatorList.ViewConverter.Header.titleView()
		case "CustomGroupOperatorList.ViewConverter.List.entireView":
            CustomGroupOperatorList.ViewConverter.List.entireView()
		case "CustomGroupOperatorList.ViewConverter.List.rowView":
            CustomGroupOperatorList.ViewConverter.List.rowView()
		case "CustomGroupOperatorList.ViewConverter.List.profileImage":
            CustomGroupOperatorList.ViewConverter.List.profileImage()
		case "CustomGroupOperatorList.ViewConverter.List.userNameLabel":
            CustomGroupOperatorList.ViewConverter.List.userNameLabel()
		case "CustomGroupOperatorList.ViewConverter.List.moreButton":
            CustomGroupOperatorList.ViewConverter.List.moreButton()
		case "CustomOpenMutedParticipantList.SwiftUI.View.Main":
            CustomOpenMutedParticipantList.SwiftUI.View.Main()
		case "CustomOpenMutedParticipantList.SwiftUI.View.CustomMain":
            CustomOpenMutedParticipantList.SwiftUI.View.CustomMain()
		case "CustomOpenMutedParticipantList.ViewConverter.Header.leftView":
            CustomOpenMutedParticipantList.ViewConverter.Header.leftView()
		case "CustomOpenMutedParticipantList.ViewConverter.Header.rightView":
            CustomOpenMutedParticipantList.ViewConverter.Header.rightView()
		case "CustomOpenMutedParticipantList.ViewConverter.Header.titleView":
            CustomOpenMutedParticipantList.ViewConverter.Header.titleView()
		case "CustomOpenMutedParticipantList.ViewConverter.List.entireView":
            CustomOpenMutedParticipantList.ViewConverter.List.entireView()
		case "CustomOpenMutedParticipantList.ViewConverter.List.rowView":
            CustomOpenMutedParticipantList.ViewConverter.List.rowView()
		case "CustomOpenMutedParticipantList.ViewConverter.List.profileImage":
            CustomOpenMutedParticipantList.ViewConverter.List.profileImage()
		case "CustomOpenMutedParticipantList.ViewConverter.List.userNameLabel":
            CustomOpenMutedParticipantList.ViewConverter.List.userNameLabel()
		case "CustomOpenMutedParticipantList.ViewConverter.List.operatorStateView":
            CustomOpenMutedParticipantList.ViewConverter.List.operatorStateView()
		case "CustomOpenMutedParticipantList.ViewConverter.List.moreButton":
            CustomOpenMutedParticipantList.ViewConverter.List.moreButton()
		case "CustomOpenBannedUserList.SwiftUI.View.Main":
            CustomOpenBannedUserList.SwiftUI.View.Main()
		case "CustomOpenBannedUserList.SwiftUI.View.CustomMain":
            CustomOpenBannedUserList.SwiftUI.View.CustomMain()
		case "CustomOpenBannedUserList.ViewConverter.Header.leftView":
            CustomOpenBannedUserList.ViewConverter.Header.leftView()
		case "CustomOpenBannedUserList.ViewConverter.Header.rightView":
            CustomOpenBannedUserList.ViewConverter.Header.rightView()
		case "CustomOpenBannedUserList.ViewConverter.Header.titleView":
            CustomOpenBannedUserList.ViewConverter.Header.titleView()
		case "CustomOpenBannedUserList.ViewConverter.List.entireView":
            CustomOpenBannedUserList.ViewConverter.List.entireView()
		case "CustomOpenBannedUserList.ViewConverter.List.rowView":
            CustomOpenBannedUserList.ViewConverter.List.rowView()
		case "CustomOpenBannedUserList.ViewConverter.List.profileImage":
            CustomOpenBannedUserList.ViewConverter.List.profileImage()
		case "CustomOpenBannedUserList.ViewConverter.List.userNameLabel":
            CustomOpenBannedUserList.ViewConverter.List.userNameLabel()
		case "CustomOpenBannedUserList.ViewConverter.List.moreButton":
            CustomOpenBannedUserList.ViewConverter.List.moreButton()
		case "CustomOpenOperatorList.SwiftUI.View.Main":
            CustomOpenOperatorList.SwiftUI.View.Main()
		case "CustomOpenOperatorList.SwiftUI.View.CustomMain":
            CustomOpenOperatorList.SwiftUI.View.CustomMain()
		case "CustomOpenOperatorList.ViewConverter.Header.leftView":
            CustomOpenOperatorList.ViewConverter.Header.leftView()
		case "CustomOpenOperatorList.ViewConverter.Header.rightView":
            CustomOpenOperatorList.ViewConverter.Header.rightView()
		case "CustomOpenOperatorList.ViewConverter.Header.titleView":
            CustomOpenOperatorList.ViewConverter.Header.titleView()
		case "CustomOpenOperatorList.ViewConverter.List.entireView":
            CustomOpenOperatorList.ViewConverter.List.entireView()
		case "CustomOpenOperatorList.ViewConverter.List.rowView":
            CustomOpenOperatorList.ViewConverter.List.rowView()
		case "CustomOpenOperatorList.ViewConverter.List.profileImage":
            CustomOpenOperatorList.ViewConverter.List.profileImage()
		case "CustomOpenOperatorList.ViewConverter.List.userNameLabel":
            CustomOpenOperatorList.ViewConverter.List.userNameLabel()
		case "CustomOpenOperatorList.ViewConverter.List.moreButton":
            CustomOpenOperatorList.ViewConverter.List.moreButton()
		default:
            Text("Unknown View")
        }
    }
}
#endif
