import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomGroupChannelList.SubView.Builder {
    struct createChannel: View {
        var body: some View {
            GroupChannelListView()
                .createChannelView { users, type in
                    CreateGroupChannelView(
                        provider: CreateGroupChannelViewProvider(
                            customUsers: users
                        )
                    )
                }
        }
    }
}

#Preview {
    CustomGroupChannelList.SubView.Builder.createChannel()
}
