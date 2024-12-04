import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomMessageSearch.ViewConverter.List {
    struct entireView: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.groupChannel?.channelURL {
                MessageSearchView(provider: MessageSearchViewProvider(channelURL: channelURL))
            }
        }
    }
}

#Preview {
    CustomMessageSearch.ViewConverter.List.entireView()
}
