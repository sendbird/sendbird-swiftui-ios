import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomOpenParticipantList.SwiftUI.View {
    struct Main: View {
        var body: some View {
            OpenParticipantListView(
                provider: OpenParticipantListViewProvider(channelURL: TestURL.openChannel)
            )
        }
    }
}

#Preview {
    CustomOpenParticipantList.SwiftUI.View.Main()
}
