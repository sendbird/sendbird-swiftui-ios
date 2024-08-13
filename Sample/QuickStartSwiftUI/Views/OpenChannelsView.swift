//
//  OpenChannelsView.swift
//  QuickStartSwiftUI
//
//  Created by Celine Moon on 7/11/24.
//

import SwiftUI

struct OpenChannelsView: View {
    var body: some View {
        OpenChannelListView()
            .openChannelView { channelURL, messageListParams in
                OpenChannelView(channelURL: channelURL, messageListParams: messageListParams)
                    .channelSettingsView { channelURL in
                        OpenChannelSettingsView(channelURL: channelURL)
                            .moderationsView { channelURL in
                                OpenModerationsView(channelURL: channelURL)
                                    .bannedUserListView { channelURL in
                                        OpenBannedUserListView(channelURL: channelURL)
                                    }
                                    .mutedParticipantListView { channelURL in
                                        OpenMutedParticipantListView(channelURL: channelURL)
                                    }
                                    .operatorListView { channelURL in
                                        OpenOperatorListView(channelURL: channelURL)
                                    }
                            }
                            .participantListView { channelURL in
                                OpenParticipantListView(channelURL: channelURL)
                            }
                    }
                    .participantListView { channelURL in
                        OpenParticipantListView(channelURL: channelURL)
                    }
            }
            .createChannelView {
                CreateOpenChannelView()
            }
    }
}
