import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomOpenChannelSettings.SubView.Builder {
    struct moderations: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.openChannel?.channelURL {
                OpenChannelSettingsView(
                    provider: OpenChannelSettingsViewProvider(channelURL: channelURL)
                )
                    .moderationsView { channelURL in
                        OpenModerationsView(provider: .init(channelURL: channelURL))
                    }
            }
        }
    }
}

#Preview {
    CustomOpenChannelSettings.SubView.Builder.moderations()
}
