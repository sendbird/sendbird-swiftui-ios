import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomGroupChannelSettings.SubView.Builder {
    struct pushSettings: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.groupChannel?.channelURL {
                GroupChannelSettingsView(
                    provider: GroupChannelSettingsViewProvider(channelURL: channelURL)
                )
                    .pushSettingsView { channelURL in
                        GroupChannelPushSettingsView(
                            provider: GroupChannelPushSettingsViewProvider(channelURL: channelURL)
                        )
                    }
            }
        }
    }
}

#Preview {
    CustomGroupChannelSettings.SubView.Builder.pushSettings()
}
