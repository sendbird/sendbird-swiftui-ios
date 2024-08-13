import SwiftUI

extension CustomGroupChannelList.SubView.Builder {
    struct groupChannel: View {
        var body: some View {
            GroupChannelListView()
                .groupChannelView { channelURL, startingPoint, messageListParams in
                    GroupChannelView(
                        channelURL: channelURL,
                        startingPoint: startingPoint,
                        messageListParams: messageListParams
                    )
                }
        }
    }
}

#Preview {
    CustomGroupChannelList.SubView.Builder.groupChannel()
}
