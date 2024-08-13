import SwiftUI

extension CustomGroupBannedUserList.SwiftUI.View {
    struct Main: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.groupChannel?.channelURL {
                GroupBannedUserListView(channelURL: channelURL)
            }
        }
    }
}

#Preview {
    CustomGroupBannedUserList.SwiftUI.View.Main()
}
