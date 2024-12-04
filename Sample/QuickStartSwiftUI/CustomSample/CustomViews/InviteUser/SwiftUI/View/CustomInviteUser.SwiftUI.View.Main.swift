import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomInviteUser.SwiftUI.View {
    struct Main: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.groupChannel?.channelURL {
                InviteUserView(provider: InviteUserViewProvider(channelURL: channelURL))
            }
        }
    }
}

#Preview {
    CustomInviteUser.SwiftUI.View.Main()
}
