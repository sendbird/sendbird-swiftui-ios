import SwiftUI
struct CustomGroupModerations: View {
    @EnvironmentObject var viewModel: CustomSampleSubViewModel
    
    var body: some View {
        if let channelURL = viewModel.groupChannel?.channelURL {
            GroupModerationsView(channelURL: channelURL)
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
