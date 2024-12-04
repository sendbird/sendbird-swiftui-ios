import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomGroupChannelSettings.SwiftUI.View {
    struct Main: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.groupChannel?.channelURL {
                GroupChannelSettingsView(provider: GroupChannelSettingsViewProvider(channelURL: channelURL))
            }
        }
    }
}

#Preview {
    CustomGroupChannelSettings.SwiftUI.View.Main()
}
