import SwiftUI

struct CustomGroupBannedUserList: View {
    @EnvironmentObject var viewModel: CustomSampleSubViewModel
    
    var body: some View {
        if let channelURL = viewModel.groupChannel?.channelURL {
            GroupBannedUserListView(channelURL: channelURL)
        }
    }
}

#Preview {
    CustomGroupBannedUserList()
}

extension CustomGroupBannedUserList {
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
