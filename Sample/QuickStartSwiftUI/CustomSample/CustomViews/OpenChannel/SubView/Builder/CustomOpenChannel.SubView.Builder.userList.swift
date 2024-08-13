import SwiftUI

extension CustomOpenChannel.SubView.Builder {
    struct userList: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.openChannel?.channelURL {
                OpenChannelView(channelURL: channelURL)
                    .participantListView { channelURL in
                        OpenParticipantListView(channelURL: channelURL)
                    }
            }
        }
    }
}

#Preview {
    CustomOpenChannel.SubView.Builder.userList()
}
