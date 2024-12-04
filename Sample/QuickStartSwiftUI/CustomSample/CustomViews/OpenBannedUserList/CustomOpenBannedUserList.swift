import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif
struct CustomOpenBannedUserList: View {
    @EnvironmentObject var viewModel: CustomSampleSubViewModel
    
    var body: some View {
        if let channelURL = viewModel.openChannel?.channelURL {
            OpenBannedUserListView(provider: OpenBannedUserListViewProvider(channelURL: channelURL))
        }
    }
}

#Preview {
    CustomOpenBannedUserList()
}

extension CustomOpenBannedUserList {
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
