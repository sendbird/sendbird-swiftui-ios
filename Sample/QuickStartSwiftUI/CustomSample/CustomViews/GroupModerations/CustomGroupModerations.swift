import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif
struct CustomGroupModerations: View {
    @EnvironmentObject var viewModel: CustomSampleSubViewModel
    
    var body: some View {
        if let channelURL = viewModel.groupChannel?.channelURL {
            GroupModerationsView(provider: .init(channelURL: channelURL))
        }
    }
}

#Preview {
    CustomGroupModerations()
}

extension CustomGroupModerations {
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
