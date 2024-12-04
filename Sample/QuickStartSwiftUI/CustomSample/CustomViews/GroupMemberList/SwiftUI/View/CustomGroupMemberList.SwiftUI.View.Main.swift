import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomGroupMemberList.SwiftUI.View {
    struct Main: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.groupChannel?.channelURL {
                GroupMemberListView(
                    provider: GroupMemberListViewProvider(channelURL: channelURL)
                )
            }
        }
    }
}
 
#Preview {
    CustomGroupMemberList.SwiftUI.View.Main()
}
