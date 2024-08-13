import SwiftUI

extension CustomGroupMutedMemberList.SwiftUI.View {
    struct Main: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.groupChannel?.channelURL {
                GroupMutedMemberListView(channelURL: channelURL)
            }
        }
    }
}

#Preview {
    CustomGroupMutedMemberList.SwiftUI.View.Main()
}
