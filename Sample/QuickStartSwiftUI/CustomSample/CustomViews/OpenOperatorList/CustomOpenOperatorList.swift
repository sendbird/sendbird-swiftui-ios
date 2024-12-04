import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif
struct CustomOpenOperatorList: View {
    var body: some View {
        OpenOperatorListView(
            provider: OpenOperatorListViewProvider(channelURL: TestURL.openChannel)
        )
    }
}

#Preview {
    CustomOpenOperatorList()
}

extension CustomOpenOperatorList {
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
