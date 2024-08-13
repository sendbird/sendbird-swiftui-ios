import SwiftUI
struct CustomGroupMutedMemberList: View {
    @EnvironmentObject var viewModel: CustomSampleSubViewModel
    
    var body: some View {
        if let channelURL = viewModel.groupChannel?.channelURL {
            GroupMutedMemberListView(channelURL: channelURL)
        }
    }
}

#Preview {
    CustomGroupMutedMemberList()
}

extension CustomGroupMutedMemberList {
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
