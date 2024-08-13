import SwiftUI
struct CustomOpenModerations: View {
    @EnvironmentObject var viewModel: CustomSampleSubViewModel
    
    var body: some View {
        if let channelURL = viewModel.openChannel?.channelURL {
            OpenModerationsView(channelURL: channelURL)
        }
    }
}

#Preview {
    CustomOpenModerations()
}

extension CustomOpenModerations {
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
