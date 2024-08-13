import SwiftUI

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
