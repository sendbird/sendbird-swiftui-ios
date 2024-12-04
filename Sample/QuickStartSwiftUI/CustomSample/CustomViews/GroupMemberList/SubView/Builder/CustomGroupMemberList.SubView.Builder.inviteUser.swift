import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomGroupMemberList.SubView.Builder {
    struct inviteUser: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.groupChannel?.channelURL {
                GroupMemberListView(
                    provider: GroupMemberListViewProvider(channelURL: channelURL)
                )
                    .inviteUserView { channelURL in
                        InviteUserView(provider: InviteUserViewProvider(channelURL: channelURL))
                    }
            }
        }
    }
}
 
#Preview {
    CustomGroupMemberList.SubView.Builder.inviteUser()
}
