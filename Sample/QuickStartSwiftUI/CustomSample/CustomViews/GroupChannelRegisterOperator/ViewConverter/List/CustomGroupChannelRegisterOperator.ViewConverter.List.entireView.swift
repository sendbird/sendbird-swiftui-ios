import SwiftUI

extension CustomGroupChannelRegisterOperator.ViewConverter.List {
    struct entireView: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
            
        var body: some View {
            if let channelURL = viewModel.groupChannel?.channelURL {
                GroupChannelRegisterOperatorView(channelURL: channelURL)
            }
        }
    }
}

#Preview {
    CustomGroupChannelRegisterOperator.ViewConverter.List.entireView()
}
