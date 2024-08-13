import SwiftUI

extension CustomOpenChannelList.SubView.Builder {
    struct createChannel: View {
        var body: some View {
            OpenChannelListView()
                .createChannelView {
                    CreateOpenChannelView()
                }
        }
    }
}

#Preview {
    CustomOpenChannelList.SubView.Builder.createChannel()
}
