import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomGroupBannedUserList.ViewConverter.List {
    struct entireView: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        @State var customFlag: Bool = false

        func CustomButton() -> Button<some View> {
            return Button {
                self.customFlag.toggle()
            } label: {
                Text("Toggle")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
            }
        }
        
        var body: some View {
            if let channelURL = viewModel.groupChannel?.channelURL {
                GroupBannedUserListView(
                    provider: GroupBannedUserListViewProvider(channelURL: channelURL)
                )
                CustomButton()
            }
        }
    }
}
 
#Preview {
    CustomGroupBannedUserList.ViewConverter.List.entireView()
}
