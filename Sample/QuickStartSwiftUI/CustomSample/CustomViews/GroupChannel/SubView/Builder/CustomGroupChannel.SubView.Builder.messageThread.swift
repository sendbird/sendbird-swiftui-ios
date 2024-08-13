import SwiftUI

extension CustomGroupChannel.SubView.Builder {
    struct messageThread: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.groupChannel?.channelURL {
                GroupChannelView(channelURL: channelURL)
                    .messageThreadView { channelURL, parentMessageId in
                        MessageThreadView(channelURL: channelURL, parentMessageId: parentMessageId)
                    }
            }
        }
    }
}

#Preview {
    CustomGroupChannel.SubView.Builder.messageThread()
}
