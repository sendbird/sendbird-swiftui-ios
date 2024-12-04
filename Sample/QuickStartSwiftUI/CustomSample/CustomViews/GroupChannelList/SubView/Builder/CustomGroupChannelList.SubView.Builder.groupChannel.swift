import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomGroupChannelList.SubView.Builder {
    struct groupChannel: View {
        var body: some View {
            GroupChannelListView()
                .groupChannelView { channelURL, startingPoint, messageListParams in
                    GroupChannelView(
                        provider: GroupChannelViewProvider(
                            channelURL: channelURL,
                            startingPoint: startingPoint,
                            messageListParams: messageListParams
                        )
                    )
                }
        }
    }
}

#Preview {
    CustomGroupChannelList.SubView.Builder.groupChannel()
}
