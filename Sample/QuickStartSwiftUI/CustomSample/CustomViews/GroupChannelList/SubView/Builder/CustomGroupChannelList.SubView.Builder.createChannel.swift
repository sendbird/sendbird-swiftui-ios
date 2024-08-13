import SwiftUI

extension CustomGroupChannelList.SubView.Builder {
    struct createChannel: View {
        var body: some View {
            GroupChannelListView()
                .createChannelView { users, type in
                    CreateGroupChannelView(users: users, type: type)
                }
        }
    }
}

#Preview {
    CustomGroupChannelList.SubView.Builder.createChannel()
}
