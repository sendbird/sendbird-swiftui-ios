import SwiftUI

extension CustomGroupChannelRegisterOperator.SwiftUI.View {
    struct Main: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.groupChannel?.channelURL {
                GroupChannelRegisterOperatorView(
                    channelURL: channelURL
                )
            }
        }
    }
}

#Preview {
    CustomGroupChannelRegisterOperator.SwiftUI.View.Main()
}
