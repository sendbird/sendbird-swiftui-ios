import SwiftUI

extension CustomGroupMemberList.SwiftUI.View {
    struct Main: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.groupChannel?.channelURL {
                GroupMemberListView(channelURL: channelURL)
            }
        }
    }
}
 
#Preview {
    CustomGroupMemberList.SwiftUI.View.Main()
}
