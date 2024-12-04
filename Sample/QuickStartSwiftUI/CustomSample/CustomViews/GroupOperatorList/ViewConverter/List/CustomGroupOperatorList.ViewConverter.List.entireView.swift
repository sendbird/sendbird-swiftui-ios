import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomGroupOperatorList.ViewConverter.List {
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
                GroupOperatorListView(
                    provider: GroupOperatorListViewProvider(channelURL: channelURL)
                )
                CustomButton()
            }
        }
    }
}
 
#Preview {
    CustomGroupOperatorList.ViewConverter.List.entireView()
}
