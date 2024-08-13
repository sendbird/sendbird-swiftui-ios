import SwiftUI

extension CustomOpenOperatorList.ViewConverter.Header {
    struct rightView: View {
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
                channelURL: TestURL.openChannel,
                headerItem: {
                    .init()
                    .rightView { config in
                        Text("Right \(customFlag ? "ON" : "OFF")")
                            .foregroundStyle(.blue)
                    }
                }
            )
            CustomButton()
        }
    }
}
 
#Preview {
    CustomOpenOperatorList.ViewConverter.Header.rightView()
}