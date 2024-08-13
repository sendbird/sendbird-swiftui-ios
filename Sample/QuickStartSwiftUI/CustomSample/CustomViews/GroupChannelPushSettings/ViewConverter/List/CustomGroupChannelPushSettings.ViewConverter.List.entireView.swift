import SwiftUI

extension CustomGroupChannelPushSettings.ViewConverter.List {
    struct entireView: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.groupChannel?.channelURL {
                GroupChannelPushSettingsView(channelURL: channelURL)
            }
        }
    }
}

#Preview {
    CustomGroupChannelPushSettings.ViewConverter.List.entireView()
}
