import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif
struct CustomOpenChannel: View {
    @EnvironmentObject var viewModel: CustomSampleSubViewModel
    
    var body: some View {
        if let channelURL = viewModel.openChannel?.channelURL {
            OpenChannelView(provider: OpenChannelViewProvider(channelURL: channelURL))
        }
    }
}

#Preview {
    CustomOpenChannel()
}

extension CustomOpenChannel {
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
        struct Media {
        }
        struct Input {
        }
    }
}
