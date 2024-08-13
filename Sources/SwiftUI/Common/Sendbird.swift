//
//  Sendbird.swift
//  SendbirdSwiftUI
//
//  Created by Tez Park on 6/27/24.
//

import SwiftUI
import SendbirdChatSDK

public struct Sendbird {
    public struct View {}
}

public extension Sendbird.View {
    struct GroupChannel {
        public struct CreateChannel {}
        public struct ChannelList {}
        public struct Channel {}
        public struct MessageSearch {}
        public struct MessageThread {}
        public struct Settings {}
        public struct PushSettings {}
        public struct RegisterOperator {}
        public struct Moderations {}
        public struct MemberList {}
        public struct InviteUser {}
        public struct BannedUserList {}
        public struct MutedMemberList {}
        public struct OperatorList {}
    }
    
    struct OpenChannel {
        public struct CreateChannel {}
        public struct ChannelList {}
        public struct Channel {}
        public struct RegisterOperator {}
        public struct Settings {}
        public struct Moderations {}
        public struct MemberList {}
        public struct BannedUserList {}
        public struct MutedParticipantList {}
        public struct OperatorList {}
    }
}

public typealias CreateGroupChannelType = Sendbird.View.GroupChannel.CreateChannel
public typealias GroupChannelListType = Sendbird.View.GroupChannel.ChannelList
public typealias GroupChannelType = Sendbird.View.GroupChannel.Channel
public typealias MessageSearchType = Sendbird.View.GroupChannel.MessageSearch
public typealias MessageThreadType = Sendbird.View.GroupChannel.MessageThread
public typealias GroupChannelSettingsType = Sendbird.View.GroupChannel.Settings
public typealias GroupChannelPushSettingsType = Sendbird.View.GroupChannel.PushSettings
public typealias GroupChannelRegisterOperatorType = Sendbird.View.GroupChannel.RegisterOperator
public typealias GroupModerationsType = Sendbird.View.GroupChannel.Moderations
public typealias GroupMemberListType = Sendbird.View.GroupChannel.MemberList
public typealias InviteUserType = Sendbird.View.GroupChannel.InviteUser
public typealias GroupBannedUserListType = Sendbird.View.GroupChannel.BannedUserList
public typealias GroupMutedMemberListType = Sendbird.View.GroupChannel.MutedMemberList
public typealias GroupOperatorListType = Sendbird.View.GroupChannel.OperatorList

public typealias CreateOpenChannelType = Sendbird.View.OpenChannel.CreateChannel
public typealias OpenChannelListType = Sendbird.View.OpenChannel.ChannelList
public typealias OpenChannelType = Sendbird.View.OpenChannel.Channel
public typealias OpenChannelRegisterOperatorType = Sendbird.View.OpenChannel.RegisterOperator
public typealias OpenChannelSettingsType = Sendbird.View.OpenChannel.Settings
public typealias OpenModerationsType = Sendbird.View.OpenChannel.Moderations
public typealias OpenMemberListType = Sendbird.View.OpenChannel.MemberList
public typealias OpenBannedUserListType = Sendbird.View.OpenChannel.BannedUserList
public typealias OpenMutedParticipantType = Sendbird.View.OpenChannel.MutedParticipantList
public typealias OpenOperatorListType = Sendbird.View.OpenChannel.OperatorList
