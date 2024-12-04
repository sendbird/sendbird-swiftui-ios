import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

struct CustomGroupMemberList: View {
    @EnvironmentObject var viewModel: CustomSampleSubViewModel
    
    var body: some View {
        if let channelURL = viewModel.groupChannel?.channelURL {
            GroupMemberListView(
                provider: GroupMemberListViewProvider(channelURL: channelURL)
            )
        }
    }
}
 
#Preview {
    CustomGroupMemberList()
}

extension CustomGroupMemberList {
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
