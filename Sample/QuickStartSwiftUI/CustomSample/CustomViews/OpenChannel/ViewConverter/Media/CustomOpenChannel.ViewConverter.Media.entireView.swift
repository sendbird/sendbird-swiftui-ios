import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomOpenChannel.ViewConverter.Media {
    struct entireView: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.openChannel?.channelURL {
                OpenChannelView(provider: OpenChannelViewProvider(channelURL: channelURL))
            }
        }
    }
}

#Preview {
    CustomOpenChannel.ViewConverter.Media.entireView()
}
