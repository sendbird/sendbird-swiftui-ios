import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif
struct CustomOpenChannelRegisterOperator: View {
    var body: some View {
        OpenChannelRegisterOperatorView(provider: .init(channelURL: TestURL.openChannel))
    }
}

#Preview {
    CustomOpenChannelRegisterOperator()
}

extension CustomOpenChannelRegisterOperator {
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
