import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomGroupMutedMemberList.SwiftUI.View {
    struct Main: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.groupChannel?.channelURL {
                GroupMutedMemberListView(
                    provider: GroupMutedMemberListViewProvider(channelURL: channelURL)
                )
            }
        }
    }
}

#Preview {
    CustomGroupMutedMemberList.SwiftUI.View.Main()
}
