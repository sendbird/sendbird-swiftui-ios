import SwiftUI

extension CustomGroupMemberList.SubView.Builder {
    struct inviteUser: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.groupChannel?.channelURL {
                GroupMemberListView(channelURL: channelURL)
                    .inviteUserView { channelURL in
                        InviteUserView(channelURL: channelURL)
                    }
            }
        }
    }
}
 
#Preview {
    CustomGroupMemberList.SubView.Builder.inviteUser()
}
