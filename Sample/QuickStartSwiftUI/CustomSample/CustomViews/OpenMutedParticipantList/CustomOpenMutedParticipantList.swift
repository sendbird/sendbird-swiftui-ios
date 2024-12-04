import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif
struct CustomOpenMutedParticipantList: View {
    @EnvironmentObject var viewModel: CustomSampleSubViewModel
    
    var body: some View {
        if let channelURL = viewModel.openChannel?.channelURL {
            OpenMutedParticipantListView(
                provider: OpenMutedParticipantListViewProvider(channelURL: channelURL)
            )
        }
    }
}

#Preview {
    CustomOpenMutedParticipantList()
}

extension CustomOpenMutedParticipantList {
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
