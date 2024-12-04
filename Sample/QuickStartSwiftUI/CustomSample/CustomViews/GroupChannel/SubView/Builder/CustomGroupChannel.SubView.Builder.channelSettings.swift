import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomGroupChannel.SubView.Builder {
    struct channelSettings: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.groupChannel?.channelURL {
                GroupChannelView(provider: GroupChannelViewProvider(channelURL: channelURL))
                    .channelSettingsView { channelURL in
                        GroupChannelSettingsView(
                            provider: GroupChannelSettingsViewProvider(channelURL: channelURL)
                        )
                    }
            }
        }
    }
}

#Preview {
    CustomGroupChannel.SubView.Builder.channelSettings()
}
