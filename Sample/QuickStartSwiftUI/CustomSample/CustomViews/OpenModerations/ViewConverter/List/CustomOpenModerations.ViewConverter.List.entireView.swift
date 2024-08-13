import SwiftUI

extension CustomOpenModerations.ViewConverter.List {
    struct entireView: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.openChannel?.channelURL {
                OpenModerationsView(channelURL: channelURL)
            }
        }
    }
}

#Preview {
    CustomOpenModerations.ViewConverter.List.entireView()
}
