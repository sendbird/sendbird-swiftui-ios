import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomOpenChannel.SwiftUI.View {
    struct Main: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.openChannel?.channelURL {
                OpenChannelView(provider: OpenChannelViewProvider(channelURL: channelURL))
            }
        }
    }
}

#Preview {
    CustomOpenChannel.SwiftUI.View.Main()
}
