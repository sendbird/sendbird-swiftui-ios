import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomMessageSearch.SubView.Builder {
    struct groupChannel: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.groupChannel?.channelURL {
                MessageSearchView(
                    provider: MessageSearchViewProvider(channelURL: channelURL)
                )
                    .groupChannelView { channelURL, startingPoint, messageListParams in
                        GroupChannelView(provider: GroupChannelViewProvider(
                                channelURL: channelURL,
                                startingPoint: startingPoint,
                                messageListParams: messageListParams
                            )
                        )
                }
            }
        }
    }
}

#Preview {
    CustomMessageSearch.SubView.Builder.groupChannel()
}
