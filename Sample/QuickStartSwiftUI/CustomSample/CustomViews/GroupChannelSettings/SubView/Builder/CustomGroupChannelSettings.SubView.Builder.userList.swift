import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomGroupChannelSettings.SubView.Builder {
    struct userList: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.groupChannel?.channelURL {
                GroupChannelSettingsView(
                    provider: GroupChannelSettingsViewProvider(channelURL: channelURL)
                )
                    .memberListView { channelURL in
                        GroupMemberListView(provider: GroupMemberListViewProvider(channelURL: channelURL))
                    }
            }
        }
    }
}

#Preview {
    CustomGroupChannelSettings.SubView.Builder.userList()
}
