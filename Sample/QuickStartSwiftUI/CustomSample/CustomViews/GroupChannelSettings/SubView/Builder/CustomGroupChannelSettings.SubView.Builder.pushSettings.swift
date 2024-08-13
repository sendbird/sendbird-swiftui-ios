import SwiftUI

extension CustomGroupChannelSettings.SubView.Builder {
    struct pushSettings: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.groupChannel?.channelURL {
                GroupChannelSettingsView(channelURL: channelURL)
                    .pushSettingsView { channelURL in
                        GroupChannelPushSettingsView(channelURL: channelURL)
                    }
            }
        }
    }
}

#Preview {
    CustomGroupChannelSettings.SubView.Builder.pushSettings()
}
