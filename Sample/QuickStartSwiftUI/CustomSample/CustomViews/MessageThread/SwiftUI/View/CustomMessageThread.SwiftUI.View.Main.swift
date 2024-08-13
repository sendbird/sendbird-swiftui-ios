import SwiftUI

extension CustomMessageThread.SwiftUI.View {
    struct Main: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.groupChannel?.channelURL,
               let parentMessageId = viewModel.parentMessage?.messageId {
                MessageThreadView(
                    channelURL: channelURL,
                    parentMessageId: parentMessageId
                )
            }
        }
    }
}

#Preview {
    CustomMessageThread.SwiftUI.View.Main()
}
