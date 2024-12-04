import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif
struct CustomGroupOperatorList: View {
    @EnvironmentObject var viewModel: CustomSampleSubViewModel
    
    var body: some View {
        if let channelURL = viewModel.groupChannel?.channelURL {
            GroupOperatorListView(
                provider: GroupOperatorListViewProvider(channelURL: channelURL)
            )
        }
    }
}

#Preview {
    CustomGroupOperatorList()
}

extension CustomGroupOperatorList {
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
