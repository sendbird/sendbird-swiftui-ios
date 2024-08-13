import SwiftUI

extension CustomOpenChannelRegisterOperator.ViewConverter.List {
    struct entireView: View {
        var body: some View {
        OpenChannelRegisterOperatorView(channelURL: TestURL.openChannelOperator)
        }
    }
}

#Preview {
    CustomOpenChannelRegisterOperator.ViewConverter.List.entireView()
}
