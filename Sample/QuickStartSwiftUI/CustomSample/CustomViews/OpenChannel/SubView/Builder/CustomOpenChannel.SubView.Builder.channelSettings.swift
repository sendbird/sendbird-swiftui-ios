import SwiftUI

extension CustomOpenChannel.SubView.Builder {
    struct channelSettings: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.openChannel?.channelURL {
                OpenChannelView(channelURL: channelURL)
                    .channelSettingsView { channelURL in
                        OpenChannelSettingsView(channelURL: channelURL)
                    }
            }
        }
    }
}

#Preview {
    CustomOpenChannel.SubView.Builder.channelSettings()
}
