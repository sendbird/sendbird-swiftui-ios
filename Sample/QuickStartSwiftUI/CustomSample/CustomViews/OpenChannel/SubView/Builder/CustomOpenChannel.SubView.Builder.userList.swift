import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomOpenChannel.SubView.Builder {
    struct userList: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.openChannel?.channelURL {
                OpenChannelView(provider: OpenChannelViewProvider(channelURL: channelURL))
                    .participantListView { channelURL in
                        OpenParticipantListView(provider: OpenParticipantListViewProvider(channelURL: channelURL))
                    }
            }
        }
    }
}

#Preview {
    CustomOpenChannel.SubView.Builder.userList()
}
