import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomOpenOperatorList.SwiftUI.View {
    struct Main: View {
        var body: some View {
            OpenOperatorListView(
                provider: OpenOperatorListViewProvider(channelURL: TestURL.openChannel)
            )
        }
    }
}

#Preview {
    CustomOpenOperatorList.SwiftUI.View.Main()
}
