import SwiftUI

extension CustomMessageThread.ViewConverter.ParentInfo {
    struct userNameLabel: View {
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
            if let channelURL = viewModel.groupChannel?.channelURL,
               let parentMessageId = viewModel.parentMessage?.messageId {
                MessageThreadView(
                    channelURL: channelURL,
                    parentMessageId: parentMessageId,
                    parentInfoItem: {
                        .init()
                        .userNameLabel { config in
                            Text("userNameLabel")
                                .foregroundStyle(customFlag ? .green : .red)
                                .background(Color.pink.opacity(0.2))
                        }
                    }
                )
                
                CustomButton()
            }
        }
    }
}

#Preview {
    CustomMessageThread.ViewConverter.ParentInfo.userNameLabel()
}
