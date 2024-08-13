import SwiftUI

extension CustomGroupChannel.SubView.Builder {
    struct channelSettings: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.groupChannel?.channelURL {
                GroupChannelView(channelURL: channelURL)
                    .channelSettingsView { channelURL in
                        GroupChannelSettingsView(channelURL: channelURL)
                    }
            }
        }
    }
}

#Preview {
    CustomGroupChannel.SubView.Builder.channelSettings()
}
