import SwiftUI

extension CustomGroupOperatorList.ViewConverter.Header {
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
            GroupOperatorListView(
                channelURL: TestURL.openChannel,
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
    CustomGroupOperatorList.ViewConverter.Header.titleView()
}
