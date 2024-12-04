import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomOpenChannelRegisterOperator.ViewConverter.List {
    struct entireView: View {
        var body: some View {
        OpenChannelRegisterOperatorView(provider: .init(channelURL: TestURL.openChannelOperator))
        }
    }
}

#Preview {
    CustomOpenChannelRegisterOperator.ViewConverter.List.entireView()
}
