import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif
struct CustomGroupChannelPushSettings: View {
    @EnvironmentObject var viewModel: CustomSampleSubViewModel
    
    var body: some View {
        if let channelURL = viewModel.groupChannel?.channelURL {
            GroupChannelPushSettingsView(
                provider: GroupChannelPushSettingsViewProvider(channelURL: channelURL)
            )
        }
    }
}

#Preview {
    CustomGroupChannelPushSettings()
}

extension CustomGroupChannelPushSettings {
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
