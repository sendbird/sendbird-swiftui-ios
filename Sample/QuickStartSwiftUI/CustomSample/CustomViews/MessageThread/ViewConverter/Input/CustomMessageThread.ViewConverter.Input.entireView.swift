import SwiftUI

extension CustomMessageThread.ViewConverter.Input {
    struct entireView: View {
        @State var customFlag: Bool = true
        @State var message: String = ""
        
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
            Text("TODO")
//            ZStack {
//                MessageThreadView(
//                    channelURL: TestURL.threadMessageChannel,
//                    parentMessageId: TestMessageId.threadMessageId,
//                    input: { viewConfig in
//                        HStack {
//                            Button {
//                                viewConfig.parentView.showFileActionSheet()
//                            } label: {
//                                Image(systemName: "plus.circle.fill")
//                                    .resizable()
//                                    .frame(width: 30, height: 30)
//                                    .foregroundStyle(customFlag ? .white : .mint)
//                            }
//                            Spacer()
//                            TextField("Enter your message", text: $message)
//                                .padding()
//                                .background(Color(uiColor: .secondarySystemBackground))
//                            Spacer()
//                            Button {
//                                viewConfig.parentView.viewModel?.sendUserMessage(text: message)
//                                self.message = ""
//                            } label: {
//                                Image(systemName: "paperplane.circle.fill")
//                                    .resizable()
//                                    .frame(width: 30, height: 30)
//                                    .foregroundStyle(customFlag ? .white : .mint)
//                            }
//                        }
//                        .padding()
//                        .frame(maxWidth: .infinity)
//                        .background(Color.indigo)
//                    }
//                )
//                CustomButton()
//            }
        }
    }

}

#Preview {
    CustomMessageThread.ViewConverter.Input.entireView()
}
