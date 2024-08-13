import SwiftUI

extension CustomOpenChannelRegisterOperator.SwiftUI.View {
    struct Main: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.openChannel?.channelURL {
                OpenChannelRegisterOperatorView(channelURL: channelURL)
            }
        }
    }
}

#Preview {
    CustomOpenChannelRegisterOperator.SwiftUI.View.Main()
}
