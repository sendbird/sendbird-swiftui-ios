import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomGroupChannelRegisterOperator.ViewConverter.List {
    struct entireView: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
            
        var body: some View {
            if let channelURL = viewModel.groupChannel?.channelURL {
                GroupChannelRegisterOperatorView(provider: .init(channelURL: channelURL))
            }
        }
    }
}

#Preview {
    CustomGroupChannelRegisterOperator.ViewConverter.List.entireView()
}
