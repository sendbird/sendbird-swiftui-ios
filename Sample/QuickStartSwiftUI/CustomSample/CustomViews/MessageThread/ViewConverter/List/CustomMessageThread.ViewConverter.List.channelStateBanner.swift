import SwiftUI

extension CustomMessageThread.ViewConverter.List {
    struct channelStateBanner: View {
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
                    listItem: {
                        .init()
                        .channelStateBanner { config in
                            HStack {
                                Spacer()
                                Text("Channel state goes here")
                                Spacer()
                            }
                            .background(customFlag ? Color.yellow : Color.indigo)
                        }
                    }
                )
                
                CustomButton()
            }
        }
    }
}

#Preview {
    CustomMessageThread.ViewConverter.List.channelStateBanner()
}
