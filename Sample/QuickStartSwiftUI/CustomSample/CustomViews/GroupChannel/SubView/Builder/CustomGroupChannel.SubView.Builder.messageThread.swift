import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomGroupChannel.SubView.Builder {
    struct messageThread: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.groupChannel?.channelURL {
                GroupChannelView(provider: GroupChannelViewProvider(channelURL: channelURL))
                    .messageThreadView { channelURL, parentMessageId in
                        MessageThreadView(
                            provider: MessageThreadViewProvider(
                                channelURL: channelURL,
                                parentMessageId: parentMessageId
                            )
                        )
                    }
            }
        }
    }
}

#Preview {
    CustomGroupChannel.SubView.Builder.messageThread()
}
