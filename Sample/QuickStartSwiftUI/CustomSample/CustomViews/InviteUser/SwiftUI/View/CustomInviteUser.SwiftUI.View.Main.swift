import SwiftUI

extension CustomInviteUser.SwiftUI.View {
    struct Main: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.groupChannel?.channelURL {
                InviteUserView(channelURL: channelURL)
            }
        }
    }
}

#Preview {
    CustomInviteUser.SwiftUI.View.Main()
}
