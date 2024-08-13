import SwiftUI

extension CustomGroupOperatorList.SwiftUI.View {
    struct Main: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.groupChannel?.channelURL {
                GroupOperatorListView(channelURL: channelURL)
            }
        }
    }
}

#Preview {
    CustomGroupOperatorList.SwiftUI.View.Main()
}
