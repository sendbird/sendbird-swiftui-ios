import SwiftUI
struct CustomGroupChannelSettings: View {
    @EnvironmentObject var viewModel: CustomSampleSubViewModel
    
    var body: some View {
        if let channelURL = viewModel.groupChannel?.channelURL {
            GroupChannelSettingsView(channelURL: channelURL)
        }
    }
}

#Preview {
    CustomGroupChannelSettings()
}

extension CustomGroupChannelSettings {
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
