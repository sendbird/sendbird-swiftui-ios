import SwiftUI

extension CustomOpenChannelSettings.SubView.Builder {
    struct userList: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.openChannel?.channelURL {
                OpenChannelSettingsView(channelURL: channelURL)
                    .participantListView { channelURL  in
                        OpenParticipantListView(channelURL: channelURL)
                    }
            }
        }
    }
}

#Preview {
    CustomOpenChannelSettings.SubView.Builder.userList()
}
