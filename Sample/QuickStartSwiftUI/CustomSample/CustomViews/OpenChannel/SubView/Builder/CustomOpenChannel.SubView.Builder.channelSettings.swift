import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomOpenChannel.SubView.Builder {
    struct channelSettings: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.openChannel?.channelURL {
                OpenChannelView(provider: OpenChannelViewProvider(channelURL: channelURL))
                    .channelSettingsView { channelURL in
                        OpenChannelSettingsView(
                            provider: OpenChannelSettingsViewProvider(channelURL: channelURL)
                        )
                    }
            }
        }
    }
}

#Preview {
    CustomOpenChannel.SubView.Builder.channelSettings()
}
