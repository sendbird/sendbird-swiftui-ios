import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomOpenOperatorList.SubView.Builder {
    struct titleView: View {
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
                OpenOperatorListView(
                    provider: OpenOperatorListViewProvider(channelURL: channelURL),
                    headerItem: {
                        .init()
                        .titleView { config in
                            Text("Header Title \(customFlag ? "ON" : "OFF")")
                        }
                    }
                )
                CustomButton()
            }
        }
    }
}
 
#Preview {
    CustomOpenOperatorList.ViewConverter.Header.titleView()
}
