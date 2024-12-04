import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomGroupChannelRegisterOperator.SwiftUI.View {
    struct Main: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.groupChannel?.channelURL {
                GroupChannelRegisterOperatorView(
                    provider: .init(channelURL: channelURL)
                )
            }
        }
    }
}

#Preview {
    CustomGroupChannelRegisterOperator.SwiftUI.View.Main()
}
