import SwiftUI

extension CustomOpenChannelSettings.SubView.Builder {
    struct moderations: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.openChannel?.channelURL {
                OpenChannelSettingsView(channelURL: channelURL)
                    .moderationsView { channelURL in
                        OpenModerationsView(channelURL: channelURL)
                    }
            }
        }
    }
}

#Preview {
    CustomOpenChannelSettings.SubView.Builder.moderations()
}
