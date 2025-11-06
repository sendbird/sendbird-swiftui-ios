//
//  OpenChannelsView.swift
//  QuickStartSwiftUI
//
//  Created by Celine Moon on 7/11/24.
//

import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

struct OpenChannelsView: View {
    var body: some View {
        OpenChannelListView()
            .openChannelView { channelURL, messageListParams in
                OpenChannelView(
                    provider: OpenChannelViewProvider(
                        channelURL: channelURL,
                        messageListParams: messageListParams
                    )
                )
                    .channelSettingsView { channelURL in
                        OpenChannelSettingsView(
                            provider: OpenChannelSettingsViewProvider(channelURL: channelURL)
                        )
                            .moderationsView { channelURL in
                                OpenModerationsView(provider: OpenModerationsViewProvider(channelURL: channelURL))
                                    .bannedUserListView { channelURL in
                                        OpenBannedUserListView(provider: OpenBannedUserListViewProvider(channelURL: channelURL))
                                    }
                                    .mutedParticipantListView { channelURL in
                                        OpenMutedParticipantListView(provider: OpenMutedParticipantListViewProvider(channelURL: channelURL))
                                    }
                                    .operatorListView { channelURL in
                                        OpenOperatorListView(provider: OpenOperatorListViewProvider(channelURL: channelURL))
                                    }
                            }
                            .participantListView { channelURL in
                                OpenParticipantListView(provider: OpenParticipantListViewProvider(channelURL: channelURL))
                            }
                    }
                    .participantListView { channelURL in
                        OpenParticipantListView(provider: OpenParticipantListViewProvider(channelURL: channelURL))
                    }
            }
            .createChannelView {
                CreateOpenChannelView()
            }
    }
}
