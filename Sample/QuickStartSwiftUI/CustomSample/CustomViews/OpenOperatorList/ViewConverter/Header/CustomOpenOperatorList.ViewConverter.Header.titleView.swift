import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomOpenOperatorList.ViewConverter.Header {
    struct titleView: View {
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
            OpenOperatorListView(
                provider: OpenOperatorListViewProvider(channelURL: TestURL.openChannel),
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
 
#Preview {
    CustomOpenOperatorList.ViewConverter.Header.titleView()
}
