//
//  GroupChannelsView.swift
//  QuickStartSwiftUI
//
//  Created by Celine Moon on 7/11/24.
//

import SwiftUI

struct GroupChannelsView: View {
    var body: some View {
        GroupChannelListView()
            .groupChannelView { channelURL, startingPoint, messageListParams in
                GroupChannelView(
                    provider: GroupChannelViewProvider(
                        channelURL: channelURL,
                        startingPoint: startingPoint,
                        messageListParams: messageListParams
                    )
                )
                    .messageThreadView { channelURL, parentMessageId in
                        MessageThreadView(
                            provider: MessageThreadViewProvider(
                                channelURL: channelURL,
                                parentMessageId: parentMessageId
                            )
                        )
                    }
                    .channelSettingsView { channelURL in
                        GroupChannelSettingsView(provider: GroupChannelSettingsViewProvider(channelURL: channelURL))
                            .moderationsView { channelURL in
                                GroupModerationsView(provider: GroupModerationsViewProvider(channelURL: channelURL))
                                    .bannedUserListView { channelURL in
                                        GroupBannedUserListView(provider: GroupBannedUserListViewProvider(channelURL: channelURL))
                                    }
                                    .mutedMemberListView { channelURL in
                                        GroupMutedMemberListView(provider: GroupMutedMemberListViewProvider(channelURL: channelURL))
                                    }
                                    .operatorListView { channelURL in
                                        GroupOperatorListView(provider: GroupOperatorListViewProvider(channelURL: channelURL))
                                            .registerOperatorView { channelURL in
                                                GroupChannelRegisterOperatorView(
                                                    provider: GroupChannelRegisterOperatorViewProvider(channelURL: channelURL)
                                                )
                                            }
                                    }
                            }
                            .pushSettingsView { channelURL in
                                GroupChannelPushSettingsView(
                                    provider: GroupChannelPushSettingsViewProvider(channelURL: channelURL)
                                )
                            }
                            .memberListView { channelURL in
                                GroupMemberListView(provider: GroupMemberListViewProvider(channelURL: channelURL))
                                    .inviteUserView { channelURL in
                                        InviteUserView(provider: InviteUserViewProvider(channelURL: channelURL))
                                    }
                            }
                            .messageSearchView { channelURL in
                                MessageSearchView(
                                    provider: MessageSearchViewProvider(channelURL: channelURL)
                                )
                            }
                    }
            }
            .createChannelView { users, type in
                CreateGroupChannelView(
                    provider: CreateGroupChannelViewProvider(customUsers: users, type: type)
                )
            }
    }
}
