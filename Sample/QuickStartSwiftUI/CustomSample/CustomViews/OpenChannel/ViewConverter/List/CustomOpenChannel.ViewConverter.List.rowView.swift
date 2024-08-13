import SwiftUI
import SendbirdChatSDK

extension CustomOpenChannel.ViewConverter.List {
    struct rowView: View {
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
            if let channelURL = viewModel.openChannel?.channelURL {
                OpenChannelView(
                    channelURL: channelURL,
                    listItem: {
                        .init()
                        .rowView { config in
                            if let userMessageView = config.message as? UserMessage {
                                HStack {
                                    Circle()
                                        .frame(width: 12, height: 12)
                                        .foregroundStyle(customFlag ? .green : .red)
                                    Text(userMessageView.message)
                                }
                                .background(Color.yellow)
                            } else {
                                HStack {
                                    Text("Not MESG")
                                }
                                .background(Color.green)
                            }
                        }
                    }
                )
                CustomButton()
            }
        }
    }
}

#Preview {
    CustomOpenChannel.ViewConverter.List.rowView()
}
