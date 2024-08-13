import SwiftUI

extension CustomGroupModerations.SwiftUI.View {
    struct Main: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.groupChannel?.channelURL {
                GroupModerationsView(channelURL: channelURL)
            }
        }
    }
}

#Preview {
    CustomGroupModerations.SwiftUI.View.Main()
}
