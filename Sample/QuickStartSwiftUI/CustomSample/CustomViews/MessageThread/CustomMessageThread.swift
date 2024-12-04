import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif
struct CustomMessageThread: View {
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

#Preview {
    CustomMessageThread()
}

extension CustomMessageThread {
    struct SwiftUI {
        struct View {
        }
    }
    struct SubView {
        struct Builder {
        }
    }
    struct ViewConverter {
        struct Header {
        }
        struct List {
        }
        struct ParentInfo {
        }
        struct Input {
        }
    }
}
