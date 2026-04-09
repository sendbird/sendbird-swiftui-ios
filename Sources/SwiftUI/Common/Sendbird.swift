//
//  Sendbird.swift
//  SendbirdSwiftUI
//
//  Created by Tez Park on 6/27/24.
//

import SwiftUI
import SendbirdChatSDK

/// The root namespace for Sendbird SDK types.
public struct Sendbird {
    /// A namespace for Sendbird SwiftUI view types.
    public struct View {}
}

public extension Sendbird.View {
    /// A namespace for group channel related view types.
    struct GroupChannel {
        /// A type for create group channel view configuration.
        public struct CreateChannel {}
        /// A type for group channel list view configuration.
        public struct ChannelList {}
        /// A type for group channel view configuration.
        public struct Channel {}
        /// A type for message search view configuration.
        public struct MessageSearch {}
        /// A type for message thread view configuration.
        public struct MessageThread {}
        /// A type for group channel settings view configuration.
        public struct Settings {}
        /// A type for group channel push settings view configuration.
        public struct PushSettings {}
        /// A type for group channel register operator view configuration.
        public struct RegisterOperator {}
        /// A type for group channel moderations view configuration.
        public struct Moderations {}
        /// A type for group channel member list view configuration.
        public struct MemberList {}
        /// A type for invite user view configuration.
        public struct InviteUser {}
        /// A type for group channel banned user list view configuration.
        public struct BannedUserList {}
        /// A type for group channel muted member list view configuration.
        public struct MutedMemberList {}
        /// A type for group channel operator list view configuration.
        public struct OperatorList {}
    }

    /// A namespace for open channel related view types.
    struct OpenChannel {
        /// A type for create open channel view configuration.
        public struct CreateChannel {}
        /// A type for open channel list view configuration.
        public struct ChannelList {}
        /// A type for open channel view configuration.
        public struct Channel {}
        /// A type for open channel register operator view configuration.
        public struct RegisterOperator {}
        /// A type for open channel settings view configuration.
        public struct Settings {}
        /// A type for open channel moderations view configuration.
        public struct Moderations {}
        /// A type for open channel participant list view configuration.
        public struct MemberList {}
        /// A type for open channel banned user list view configuration.
        public struct BannedUserList {}
        /// A type for open channel muted participant list view configuration.
        public struct MutedParticipantList {}
        /// A type for open channel operator list view configuration.
        public struct OperatorList {}
    }
}

/// A type alias for the create group channel view configuration.
public typealias CreateGroupChannelType = Sendbird.View.GroupChannel.CreateChannel
/// A type alias for the group channel list view configuration.
public typealias GroupChannelListType = Sendbird.View.GroupChannel.ChannelList
/// A type alias for the group channel view configuration.
public typealias GroupChannelType = Sendbird.View.GroupChannel.Channel
/// A type alias for the message search view configuration.
public typealias MessageSearchType = Sendbird.View.GroupChannel.MessageSearch
/// A type alias for the message thread view configuration.
public typealias MessageThreadType = Sendbird.View.GroupChannel.MessageThread
/// A type alias for the group channel settings view configuration.
public typealias GroupChannelSettingsType = Sendbird.View.GroupChannel.Settings
/// A type alias for the group channel push settings view configuration.
public typealias GroupChannelPushSettingsType = Sendbird.View.GroupChannel.PushSettings
/// A type alias for the group channel register operator view configuration.
public typealias GroupChannelRegisterOperatorType = Sendbird.View.GroupChannel.RegisterOperator
/// A type alias for the group channel moderations view configuration.
public typealias GroupModerationsType = Sendbird.View.GroupChannel.Moderations
/// A type alias for the group channel member list view configuration.
public typealias GroupMemberListType = Sendbird.View.GroupChannel.MemberList
/// A type alias for the invite user view configuration.
public typealias InviteUserType = Sendbird.View.GroupChannel.InviteUser
/// A type alias for the group channel banned user list view configuration.
public typealias GroupBannedUserListType = Sendbird.View.GroupChannel.BannedUserList
/// A type alias for the group channel muted member list view configuration.
public typealias GroupMutedMemberListType = Sendbird.View.GroupChannel.MutedMemberList
/// A type alias for the group channel operator list view configuration.
public typealias GroupOperatorListType = Sendbird.View.GroupChannel.OperatorList

/// A type alias for the create open channel view configuration.
public typealias CreateOpenChannelType = Sendbird.View.OpenChannel.CreateChannel
/// A type alias for the open channel list view configuration.
public typealias OpenChannelListType = Sendbird.View.OpenChannel.ChannelList
/// A type alias for the open channel view configuration.
public typealias OpenChannelType = Sendbird.View.OpenChannel.Channel
/// A type alias for the open channel register operator view configuration.
public typealias OpenChannelRegisterOperatorType = Sendbird.View.OpenChannel.RegisterOperator
/// A type alias for the open channel settings view configuration.
public typealias OpenChannelSettingsType = Sendbird.View.OpenChannel.Settings
/// A type alias for the open channel moderations view configuration.
public typealias OpenModerationsType = Sendbird.View.OpenChannel.Moderations
/// A type alias for the open channel participant list view configuration.
public typealias OpenMemberListType = Sendbird.View.OpenChannel.MemberList
/// A type alias for the open channel banned user list view configuration.
public typealias OpenBannedUserListType = Sendbird.View.OpenChannel.BannedUserList
/// A type alias for the open channel muted participant list view configuration.
public typealias OpenMutedParticipantType = Sendbird.View.OpenChannel.MutedParticipantList
/// A type alias for the open channel operator list view configuration.
public typealias OpenOperatorListType = Sendbird.View.OpenChannel.OperatorList
