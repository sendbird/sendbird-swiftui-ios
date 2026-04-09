//
//  SBViewConverterSet.swift
//  SendbirdSwiftUI
//
//  Created by Tez Park on 6/10/24.
//

import Foundation

/// A set of view converters for customizing SwiftUI views.
public class SBViewConverterSet {
    // MARK: - ViewConverter

    /// The view converter for the create group channel view.
    public static var CreateGroupChannel = CreateGroupChannelViewConverter()
    /// The view converter for the create open channel view.
    public static var CreateOpenChannel = CreateOpenChannelViewConverter()
    /// The view converter for the group channel view.
    public static var GroupChannel = GroupChannelViewConverter()
    /// The view converter for the group channel list view.
    public static var GroupChannelList = GroupChannelListViewConverter()
    /// The view converter for the group channel push settings view.
    public static var GroupChannelPushSettings = GroupChannelPushSettingsViewConverter()
    /// The view converter for the group channel register operator view.
    public static var GroupChannelRegisterOperator = GroupChannelRegisterOperatorViewConverter()
    /// The view converter for the group channel settings view.
    public static var GroupChannelSettings = GroupChannelSettingsViewConverter()
    /// The view converter for the group moderations view.
    public static var GroupModerations = GroupModerationsViewConverter()
    /// The view converter for the group member list view.
    public static var GroupMemberList = GroupMemberListViewConverter()
    /// The view converter for the group banned user list view.
    public static var GroupBannedUserList = GroupBannedUserListViewConverter()
    /// The view converter for the group muted member list view.
    public static var GroupMutedMemberList = GroupMutedMemberListViewConverter()
    /// The view converter for the group operator list view.
    public static var GroupOperatorList = GroupOperatorListViewConverter()
    /// The view converter for the invite user view.
    public static var InviteUser = InviteUserViewConverter()
    /// The view converter for the message search view.
    public static var MessageSearch = MessageSearchViewConverter()
    /// The view converter for the message thread view.
    public static var MessageThread = MessageThreadViewConverter()
    /// The view converter for the open channel view.
    public static var OpenChannel = OpenChannelViewConverter()
    /// The view converter for the open channel list view.
    public static var OpenChannelList = OpenChannelListViewConverter()
    /// The view converter for the open channel register operator view.
    public static var OpenChannelRegisterOperator = OpenChannelRegisterOperatorViewConverter()
    /// The view converter for the open channel settings view.
    public static var OpenChannelSettings = OpenChannelSettingsViewConverter()
    /// The view converter for the open moderations view.
    public static var OpenModerations = OpenModerationsViewConverter()
    /// The view converter for the open participant list view.
    public static var OpenParticipantList = OpenParticipantListViewConverter()
    /// The view converter for the open banned user list view.
    public static var OpenBannedUserList = OpenBannedUserListViewConverter()
    /// The view converter for the open muted participant list view.
    public static var OpenMutedParticipantList = OpenMutedParticipantListViewConverter()
    /// The view converter for the open operator list view.
    public static var OpenOperatorList = OpenOperatorListViewConverter()

    /// Resets all view converters to their default values.
    public static func resetAll() {
        SBViewConverterSet.CreateGroupChannel = CreateGroupChannelViewConverter()
        SBViewConverterSet.CreateOpenChannel = CreateOpenChannelViewConverter()
        SBViewConverterSet.GroupChannel = GroupChannelViewConverter()
        SBViewConverterSet.GroupChannelList = GroupChannelListViewConverter()
        SBViewConverterSet.GroupChannelPushSettings = GroupChannelPushSettingsViewConverter()
        SBViewConverterSet.GroupChannelRegisterOperator = GroupChannelRegisterOperatorViewConverter()
        SBViewConverterSet.GroupChannelSettings = GroupChannelSettingsViewConverter()
        SBViewConverterSet.GroupModerations = GroupModerationsViewConverter()
        SBViewConverterSet.GroupMemberList = GroupMemberListViewConverter()
        SBViewConverterSet.GroupBannedUserList = GroupBannedUserListViewConverter()
        SBViewConverterSet.GroupMutedMemberList = GroupMutedMemberListViewConverter()
        SBViewConverterSet.GroupOperatorList = GroupOperatorListViewConverter()
        SBViewConverterSet.InviteUser = InviteUserViewConverter()
        SBViewConverterSet.MessageSearch = MessageSearchViewConverter()
        SBViewConverterSet.MessageThread = MessageThreadViewConverter()
        SBViewConverterSet.OpenChannel = OpenChannelViewConverter()
        SBViewConverterSet.OpenChannelList = OpenChannelListViewConverter()
        SBViewConverterSet.OpenChannelRegisterOperator = OpenChannelRegisterOperatorViewConverter()
        SBViewConverterSet.OpenChannelSettings = OpenChannelSettingsViewConverter()
        SBViewConverterSet.OpenModerations = OpenModerationsViewConverter()
        SBViewConverterSet.OpenParticipantList = OpenParticipantListViewConverter()
        SBViewConverterSet.OpenBannedUserList = OpenBannedUserListViewConverter()
        SBViewConverterSet.OpenMutedParticipantList = OpenMutedParticipantListViewConverter()
        SBViewConverterSet.OpenOperatorList = OpenOperatorListViewConverter()
        
    }
}
