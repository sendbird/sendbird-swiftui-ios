import SwiftUI
struct CustomGroupChannel: View {
    @EnvironmentObject var viewModel: CustomSampleSubViewModel
    
    var body: some View {
        if let channelURL = viewModel.groupChannel?.channelURL {
            GroupChannelView(channelURL: channelURL)
        }
    }
}

#Preview {
    CustomGroupChannel()
}

extension CustomGroupChannel {
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
        struct Input {
        }
    }
}
