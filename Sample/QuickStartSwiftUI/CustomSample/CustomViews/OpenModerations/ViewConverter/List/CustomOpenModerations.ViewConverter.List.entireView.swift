import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomOpenModerations.ViewConverter.List {
    struct entireView: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.openChannel?.channelURL {
                OpenModerationsView(provider: .init(channelURL: channelURL))
            }
        }
    }
}

#Preview {
    CustomOpenModerations.ViewConverter.List.entireView()
}
