import SwiftUI
struct CustomOpenBannedUserList: View {
    @EnvironmentObject var viewModel: CustomSampleSubViewModel
    
    var body: some View {
        if let channelURL = viewModel.openChannel?.channelURL {
            OpenBannedUserListView(channelURL: channelURL)
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
