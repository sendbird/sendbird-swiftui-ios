import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomCreateOpenChannel.ViewConverter.List {
    struct selectionButton: View {
        var body: some View {
            CreateOpenChannelView()
        }
    }
}

#Preview {
    CustomCreateOpenChannel.ViewConverter.List.selectionButton()
}
