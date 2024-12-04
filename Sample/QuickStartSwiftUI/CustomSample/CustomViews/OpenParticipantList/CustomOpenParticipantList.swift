import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

struct CustomOpenParticipantList: View {
    var body: some View {
        OpenParticipantListView(
            provider: OpenParticipantListViewProvider(channelURL: TestURL.openChannel)
        )
    }
}

#Preview {
    CustomOpenParticipantList()
}

extension CustomOpenParticipantList {
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
