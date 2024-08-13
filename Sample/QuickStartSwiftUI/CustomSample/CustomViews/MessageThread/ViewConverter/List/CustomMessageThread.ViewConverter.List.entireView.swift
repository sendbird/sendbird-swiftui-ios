import SwiftUI

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
                channelURL: TestURL.threadMessageChannel, 
                parentMessageId: TestMessageId.threadMessageId,
                list: { config in
                    List(config.messages) { message in
                        HStack {
                            Circle()
                                .frame(width: 12, height: 12)
                                .foregroundStyle(customFlag ? .green : .red)
                            Text(message.message)
                        }
                    }
                }
            )
            
            CustomButton()
        }
    }
}

#Preview {
    CustomMessageThread.ViewConverter.List.entireView()
}
