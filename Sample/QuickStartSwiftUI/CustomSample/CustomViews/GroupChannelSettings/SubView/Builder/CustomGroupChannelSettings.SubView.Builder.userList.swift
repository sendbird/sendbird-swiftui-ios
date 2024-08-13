import SwiftUI

extension CustomGroupChannelSettings.SubView.Builder {
    struct userList: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.groupChannel?.channelURL {
                GroupChannelSettingsView(channelURL: channelURL)
                    .memberListView { channelURL in
                        GroupMemberListView(channelURL: channelURL)
                    }
            }
        }
    }
}

#Preview {
    CustomGroupChannelSettings.SubView.Builder.userList()
}
