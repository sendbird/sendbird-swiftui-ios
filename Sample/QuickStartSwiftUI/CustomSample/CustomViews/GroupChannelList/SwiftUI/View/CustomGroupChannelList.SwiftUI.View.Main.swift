import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomGroupChannelList.SwiftUI.View {
    struct Main: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            GroupChannelListView()
        }
    }
}

#Preview {
    CustomGroupChannelList.SwiftUI.View.Main()
}
