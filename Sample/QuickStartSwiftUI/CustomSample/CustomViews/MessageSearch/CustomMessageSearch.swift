import SwiftUI
struct CustomMessageSearch: View {
    @EnvironmentObject var viewModel: CustomSampleSubViewModel
    
    var body: some View {
        if let channelURL = viewModel.groupChannel?.channelURL {
            MessageSearchView(channelURL: channelURL)
        }
    }
}

#Preview {
    CustomMessageSearch()
}

extension CustomMessageSearch {
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
