import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

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
