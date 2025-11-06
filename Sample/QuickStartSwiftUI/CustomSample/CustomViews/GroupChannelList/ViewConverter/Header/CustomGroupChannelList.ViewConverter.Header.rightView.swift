import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomGroupChannelList.ViewConverter.Header {
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
            GroupChannelListView(
                headerItem: {
                    .init()
                    .rightView { config in
                        Text("Right \(customFlag ? "ON" : "OFF")")
                            .foregroundStyle(.blue)
                        
                        // This removes the right bar button.
                        // Color.clear.frame(width: 0, height: 0)
                    }
                }
            )
            CustomButton()
        }
    }
}

#Preview {
    CustomGroupChannelList.ViewConverter.Header.rightView()
}
