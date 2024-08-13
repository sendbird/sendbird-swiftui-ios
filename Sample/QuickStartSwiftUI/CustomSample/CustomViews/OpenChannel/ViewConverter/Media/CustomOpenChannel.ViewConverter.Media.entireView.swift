import SwiftUI

extension CustomOpenChannel.ViewConverter.Media {
    struct entireView: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.openChannel?.channelURL {
                OpenChannelView(channelURL: channelURL)
            }
        }
    }
}

#Preview {
    CustomOpenChannel.ViewConverter.Media.entireView()
}
