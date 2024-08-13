import SwiftUI

extension CustomMessageThread.ViewConverter.ParentInfo {
    struct reactionView: View {
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
                        .reactionView { config in
                            Text("reactionView")
                                .frame(height: 80)
                                .foregroundStyle(customFlag ? .green : .red)
                                .background(.yellow)
                        }
                    }
                )
                
                CustomButton()
            }
        }
    }
}

#Preview {
    CustomMessageThread.ViewConverter.ParentInfo.reactionView()
}
