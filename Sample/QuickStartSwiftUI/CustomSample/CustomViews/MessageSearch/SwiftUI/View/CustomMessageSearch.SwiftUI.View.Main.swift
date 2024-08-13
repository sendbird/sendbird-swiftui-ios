import SwiftUI

extension CustomMessageSearch.SwiftUI.View {
    struct Main: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.groupChannel?.channelURL {
                MessageSearchView(channelURL: channelURL)
            }
        }
    }
}

#Preview {
    CustomMessageSearch.SwiftUI.View.Main()
}
