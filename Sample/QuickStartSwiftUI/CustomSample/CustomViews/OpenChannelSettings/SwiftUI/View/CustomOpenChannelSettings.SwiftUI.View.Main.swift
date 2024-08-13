import SwiftUI

extension CustomOpenChannelSettings.SwiftUI.View {
    struct Main: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.openChannel?.channelURL {
                OpenChannelSettingsView(channelURL: channelURL)
            }
        }
    }
}

#Preview {
    CustomOpenChannelSettings.SwiftUI.View.Main()
}
