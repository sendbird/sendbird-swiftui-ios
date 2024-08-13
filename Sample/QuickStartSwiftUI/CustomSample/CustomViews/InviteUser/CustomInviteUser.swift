import SwiftUI
struct CustomInviteUser: View {
    @EnvironmentObject var viewModel: CustomSampleSubViewModel
    
    var body: some View {
        if let channelURL = viewModel.groupChannel?.channelURL {
            InviteUserView(channelURL: channelURL)
        }
    }
}

#Preview {
    CustomInviteUser()
}

extension CustomInviteUser {
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
