import SwiftUI

extension CustomMessageSearch.SubView.Builder {
    struct groupChannel: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.groupChannel?.channelURL {
                MessageSearchView(channelURL: channelURL)
                    .groupChannelView { channelURL, startingPoint, messageListParams in
                        GroupChannelView(
                            channelURL: channelURL,
                            startingPoint: startingPoint,
                            messageListParams: messageListParams)
                    }
            }
        }
    }
}

#Preview {
    CustomMessageSearch.SubView.Builder.groupChannel()
}
