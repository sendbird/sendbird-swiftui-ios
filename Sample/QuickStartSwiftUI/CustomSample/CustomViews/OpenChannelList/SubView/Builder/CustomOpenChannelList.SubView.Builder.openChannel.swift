import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomOpenChannelList.SubView.Builder {
    struct openChannel: View {
        var body: some View {
            OpenChannelListView()
                .openChannelView { channelURL, messageListParams in
                    OpenChannelView(
                        provider: OpenChannelViewProvider(
                            channelURL: channelURL,
                            messageListParams: messageListParams
                        )
                    )
                }
        }
    }
}

#Preview {
    CustomOpenChannelList.SubView.Builder.openChannel()
}
