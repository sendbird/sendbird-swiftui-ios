import SwiftUI

extension CustomOpenMutedParticipantList.SwiftUI.View {
    struct Main: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.openChannel?.channelURL {
                OpenMutedParticipantListView(channelURL: channelURL)
            }
        }
    }
}

#Preview {
    CustomOpenMutedParticipantList.SwiftUI.View.Main()
}
