import SwiftUI

extension CustomMessageThread.ViewConverter.ParentInfo {
    struct entireContent: View {
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
                        .parentInfoView { config in
                            Text("parent-info-view")
                                .frame(height: 300)
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
    CustomMessageThread.ViewConverter.ParentInfo.entireContent()
}
