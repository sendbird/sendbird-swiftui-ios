import SwiftUI

extension CustomGroupOperatorList.SubView.Builder {
    struct registerOperator: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.groupChannel?.channelURL {
                GroupOperatorListView(channelURL: channelURL)
                    .registerOperatorView { channelURL in
                        GroupChannelRegisterOperatorView(channelURL: channelURL)
                    }
            }
        }
    }
}

#Preview {
    CustomGroupOperatorList.SubView.Builder.registerOperator()
}
