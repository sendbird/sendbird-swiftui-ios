import SwiftUI

extension CustomOpenParticipantList.SwiftUI.View {
    struct Main: View {
        var body: some View {
            OpenParticipantListView(channelURL: TestURL.openChannel)
        }
    }
}

#Preview {
    CustomOpenParticipantList.SwiftUI.View.Main()
}
