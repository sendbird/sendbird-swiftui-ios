import SwiftUI

extension CustomGroupChannelSettings.SubView.Builder {
    struct moderations: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.groupChannel?.channelURL {
                GroupChannelSettingsView(channelURL: channelURL)
                    .moderationsView { channelURL in
                        GroupModerationsView(channelURL: channelURL)
                    }
            }
        }
    }
}

#Preview {
    CustomGroupChannelSettings.SubView.Builder.moderations()
}
