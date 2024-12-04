import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomCreateGroupChannel.SwiftUI.View {
    struct Main: View {
        var body: some View {
            CreateGroupChannelView()
        }
    }
}

#Preview {
    CustomCreateGroupChannel.SwiftUI.View.Main()
}
