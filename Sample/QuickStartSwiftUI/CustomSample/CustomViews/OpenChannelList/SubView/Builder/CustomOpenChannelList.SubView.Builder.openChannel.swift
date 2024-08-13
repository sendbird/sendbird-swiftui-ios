import SwiftUI

extension CustomOpenChannelList.SubView.Builder {
    struct openChannel: View {
        var body: some View {
            OpenChannelListView()
                .openChannelView { channelURL, messageListParams in
                    OpenChannelView(channelURL: channelURL, messageListParams: messageListParams)
                }
        }
    }
}

#Preview {
    CustomOpenChannelList.SubView.Builder.openChannel()
}
