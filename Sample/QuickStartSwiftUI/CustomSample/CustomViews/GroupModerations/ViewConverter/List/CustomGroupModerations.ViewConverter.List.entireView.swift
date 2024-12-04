import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomGroupModerations.ViewConverter.List {
    struct entireView: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.groupChannel?.channelURL {
                GroupModerationsView(provider: .init(channelURL: channelURL))
            }
        }
    }
}

#Preview {
    CustomGroupModerations.ViewConverter.List.entireView()
}
