import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomOpenChannelSettings.ViewConverter.List {
    struct entireView: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.openChannel?.channelURL {
                OpenChannelSettingsView(
                    provider: OpenChannelSettingsViewProvider(channelURL: channelURL)
                )
            }
        }
    }
}

#Preview {
    CustomOpenChannelSettings.ViewConverter.List.entireView()
}
