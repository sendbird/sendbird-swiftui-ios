import SwiftUI

extension CustomOpenModerations.SwiftUI.View {
    struct Main: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.openChannel?.channelURL {
                OpenModerationsView(channelURL: channelURL)
            }
        }
    }
}

#Preview {
    CustomOpenModerations.SwiftUI.View.Main()
}
