import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomCreateOpenChannel.ViewConverter.List {
    struct profileImage: View {
        var body: some View {
            CreateOpenChannelView()
        }
    }
}

#Preview {
    CustomCreateOpenChannel.ViewConverter.List.profileImage()
}
