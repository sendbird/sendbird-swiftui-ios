import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomOpenBannedUserList.SwiftUI.View {
    struct Main: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        var body: some View {
            if let channelURL = viewModel.openChannel?.channelURL {
                OpenBannedUserListView(provider: OpenBannedUserListViewProvider(channelURL: channelURL))
            }
        }
    }
}

#Preview {
    CustomOpenBannedUserList.SwiftUI.View.Main()
}
