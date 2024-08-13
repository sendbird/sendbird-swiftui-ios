import SwiftUI

extension CustomGroupChannel.SwiftUI.View {
    struct Main: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel

        var body: some View {
            if let channelURL = viewModel.groupChannel?.channelURL {
                GroupChannelView(channelURL: channelURL)
            }
        }
    }
}

#Preview {
    CustomGroupChannel.SwiftUI.View.Main()
}
