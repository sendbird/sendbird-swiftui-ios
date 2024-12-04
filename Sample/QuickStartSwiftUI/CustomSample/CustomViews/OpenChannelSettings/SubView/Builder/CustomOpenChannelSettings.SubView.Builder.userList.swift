import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomOpenChannelSettings.SubView.Builder {
    struct userList: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.openChannel?.channelURL {
                OpenChannelSettingsView(
                    provider: OpenChannelSettingsViewProvider(channelURL: channelURL)
                )
                    .participantListView { channelURL  in
                        OpenParticipantListView(
                            provider: OpenParticipantListViewProvider(channelURL: channelURL)
                        )
                    }
            }
        }
    }
}

#Preview {
    CustomOpenChannelSettings.SubView.Builder.userList()
}
