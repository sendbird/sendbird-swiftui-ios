import SwiftUI

extension CustomMessageThread.ViewConverter.Header {
    struct subtitleLabel: View {
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
                    headerItem: {
                        .init()
                        .subtitleLabel { config in
                            Button {
                                print("subtitleLabel")
                            } label: {
                                Text("subtitleLabel \(customFlag ? "ON" : "OFF")")
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
    CustomMessageThread.ViewConverter.Header.subtitleLabel()
}
