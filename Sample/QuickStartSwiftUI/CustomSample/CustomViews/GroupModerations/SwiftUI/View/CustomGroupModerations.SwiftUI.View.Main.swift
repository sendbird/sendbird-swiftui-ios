import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomGroupModerations.SwiftUI.View {
    struct Main: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.groupChannel?.channelURL {
                GroupModerationsView(provider: .init(channelURL: channelURL))
            }
        }
    }
}

#Preview {
    CustomGroupModerations.SwiftUI.View.Main()
}
