//
//  SBViewConverterSet.swift
//  SendbirdSwiftUI
//
//  Created by Tez Park on 6/10/24.
//

import Foundation

public class SBViewConverterSet {
    // MARK: - ViewConverter
    public static var CreateGroupChannel = CreateGroupChannelViewConverter()
    public static var CreateOpenChannel = CreateOpenChannelViewConverter()
    public static var GroupChannel = GroupChannelViewConverter()
    public static var GroupChannelList = GroupChannelListViewConverter()
    public static var GroupChannelPushSettings = GroupChannelPushSettingsViewConverter()
    public static var GroupChannelRegisterOperator = GroupChannelRegisterOperatorViewConverter()
    public static var GroupChannelSettings = GroupChannelSettingsViewConverter()
    public static var GroupModerations = GroupModerationsViewConverter()
    public static var GroupMemberList = GroupMemberListViewConverter()
    public static var GroupBannedUserList = GroupBannedUserListViewConverter()
    public static var GroupMutedMemberList = GroupMutedMemberListViewConverter()
    public static var GroupOperatorList = GroupOperatorListViewConverter()
    public static var InviteUser = InviteUserViewConverter()
    public static var MessageSearch = MessageSearchViewConverter()
    public static var MessageThread = MessageThreadViewConverter()
    public static var OpenChannel = OpenChannelViewConverter()
    public static var OpenChannelList = OpenChannelListViewConverter()
    public static var OpenChannelRegisterOperator = OpenChannelRegisterOperatorViewConverter()
    public static var OpenChannelSettings = OpenChannelSettingsViewConverter()
    public static var OpenModerations = OpenModerationsViewConverter()
    public static var OpenParticipantList = OpenParticipantListViewConverter()
    public static var OpenBannedUserList = OpenBannedUserListViewConverter()
    public static var OpenMutedParticipantList = OpenMutedParticipantListViewConverter()
    public static var OpenOperatorList = OpenOperatorListViewConverter()
    
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
