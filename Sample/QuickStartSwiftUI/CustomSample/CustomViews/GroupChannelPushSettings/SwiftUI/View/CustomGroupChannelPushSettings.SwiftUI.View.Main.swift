import SwiftUI

extension CustomGroupChannelPushSettings.SwiftUI.View {
    struct Main: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.groupChannel?.channelURL {
                GroupChannelPushSettingsView(channelURL: channelURL)
            }
        }
    }
}

#Preview {
    CustomGroupChannelPushSettings.SwiftUI.View.Main()
}
