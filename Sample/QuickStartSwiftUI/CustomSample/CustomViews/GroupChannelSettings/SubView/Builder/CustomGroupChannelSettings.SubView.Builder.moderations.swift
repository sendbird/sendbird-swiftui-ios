import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomGroupChannelSettings.SubView.Builder {
    struct moderations: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.groupChannel?.channelURL {
                GroupChannelSettingsView(
                    provider: GroupChannelSettingsViewProvider(channelURL: channelURL)
                )
                    .moderationsView { channelURL in
                        GroupModerationsView(provider: .init(channelURL: channelURL))
                    }
            }
        }
    }
}

#Preview {
    CustomGroupChannelSettings.SubView.Builder.moderations()
}
