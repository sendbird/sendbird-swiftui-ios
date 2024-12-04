import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomGroupOperatorList.SubView.Builder {
    struct registerOperator: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.groupChannel?.channelURL {
                GroupOperatorListView(provider: .init(channelURL: channelURL))
                    .registerOperatorView { channelURL in
                        GroupChannelRegisterOperatorView(provider: .init(channelURL: channelURL))
                    }
            }
        }
    }
}

#Preview {
    CustomGroupOperatorList.SubView.Builder.registerOperator()
}
