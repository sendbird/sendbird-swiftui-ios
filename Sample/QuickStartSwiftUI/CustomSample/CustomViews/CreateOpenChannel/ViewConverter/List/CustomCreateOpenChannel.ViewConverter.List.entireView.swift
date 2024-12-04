import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomCreateOpenChannel.ViewConverter.List {
    struct entireView: View {
        var body: some View {
            CreateOpenChannelView()
        }
    }
}

#Preview {
    CustomCreateOpenChannel.ViewConverter.List.entireView()
}
