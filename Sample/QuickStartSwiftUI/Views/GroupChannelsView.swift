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
                    channelURL: channelURL,
                    startingPoint: startingPoint,
                    messageListParams: messageListParams
                )
                    .messageThreadView { channelURL, parentMessageId in
                        MessageThreadView(channelURL: channelURL, parentMessageId: parentMessageId)
                    }
                    .channelSettingsView { channelURL in
                        GroupChannelSettingsView(channelURL: channelURL)
                            .moderationsView { channelURL in
                                GroupModerationsView(channelURL: channelURL)
                                    .bannedUserListView { channelURL in
                                        GroupBannedUserListView(channelURL: channelURL)
                                    }
                                    .mutedMemberListView { channelURL in
                                        GroupMutedMemberListView(channelURL: channelURL)
                                    }
                                    .operatorListView { channelURL in
                                        GroupOperatorListView(channelURL: channelURL)
                                            .registerOperatorView { channelURL in
                                                GroupChannelRegisterOperatorView(channelURL: channelURL)
                                            }
                                    }
                            }
                            .pushSettingsView { channelURL in
                                GroupChannelPushSettingsView(channelURL: channelURL)
                            }
                            .memberListView { channelURL in
                                GroupMemberListView(channelURL: channelURL)
                                    .inviteUserView { channelURL in
                                        InviteUserView(channelURL: channelURL)
                                    }
                            }
                            .messageSearchView { channelURL in
                                MessageSearchView(channelURL: channelURL)
                            }
                    }
            }
            .createChannelView { users, type in
                CreateGroupChannelView(users: users, type: type)
            }
    }
}
