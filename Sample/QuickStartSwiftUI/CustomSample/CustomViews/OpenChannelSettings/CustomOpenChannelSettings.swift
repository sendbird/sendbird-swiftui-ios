import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif
struct CustomOpenChannelSettings: View {
    @EnvironmentObject var viewModel: CustomSampleSubViewModel
    
    var body: some View {
        if let channelURL = viewModel.openChannel?.channelURL {
            OpenChannelSettingsView(
                provider: OpenChannelSettingsViewProvider(channelURL: channelURL)
            )
        }
    }
}

#Preview {
    CustomOpenChannelSettings()
}

extension CustomOpenChannelSettings {
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
    }
}
