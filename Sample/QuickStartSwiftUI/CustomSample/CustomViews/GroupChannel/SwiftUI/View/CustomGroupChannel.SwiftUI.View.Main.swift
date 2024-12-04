import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomGroupChannel.SwiftUI.View {
    struct Main: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        @StateObject var provider = GroupChannelViewProvider(channelURL: "")
        
        var body: some View {
            GroupChannelView(provider: provider)
                .onAppear {
                    if let channelURL = viewModel.groupChannel?.channelURL {
                        provider.setup(channelURL: channelURL)
                    }
                }
        }
    }
}


#Preview {
    CustomGroupChannel.SwiftUI.View.Main()
}
