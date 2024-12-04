import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomMessageThread.SwiftUI.View {
    struct Main: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.groupChannel?.channelURL,
               let parentMessageId = viewModel.parentMessage?.messageId {
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

#Preview {
    CustomMessageThread.SwiftUI.View.Main()
}
