import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomMessageThread.ViewConverter.List {
    struct entireView: View {
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
            MessageThreadView(
                provider: MessageThreadViewProvider(
                    channelURL: TestURL.threadMessageChannel,
                    parentMessageId: TestMessageId.threadMessageId
                )
            )
            
            CustomButton()
        }
    }
}

#Preview {
    CustomMessageThread.ViewConverter.List.entireView()
}
