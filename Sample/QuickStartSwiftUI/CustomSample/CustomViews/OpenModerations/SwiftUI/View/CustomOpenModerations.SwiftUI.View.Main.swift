import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomOpenModerations.SwiftUI.View {
    struct Main: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.openChannel?.channelURL {
                OpenModerationsView(provider: .init(channelURL: channelURL))
            }
        }
    }
}

#Preview {
    CustomOpenModerations.SwiftUI.View.Main()
}
