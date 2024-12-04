import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomCreateOpenChannel.ViewConverter.List {
    struct userNameLabel: View {
        var body: some View {
            CreateOpenChannelView()
        }
    }
}

#Preview {
    CustomCreateOpenChannel.ViewConverter.List.userNameLabel()
}
