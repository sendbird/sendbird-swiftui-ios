import SwiftUI

extension CustomOpenOperatorList.SwiftUI.View {
    struct Main: View {
        var body: some View {
            OpenOperatorListView(channelURL: TestURL.openChannel)
        }
    }
}

#Preview {
    CustomOpenOperatorList.SwiftUI.View.Main()
}
