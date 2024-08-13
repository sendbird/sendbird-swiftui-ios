import SwiftUI
struct CustomOpenMutedParticipantList: View {
    @EnvironmentObject var viewModel: CustomSampleSubViewModel
    
    var body: some View {
        if let channelURL = viewModel.openChannel?.channelURL {
            OpenMutedParticipantListView(channelURL: channelURL)
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
