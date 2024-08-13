import SwiftUI

extension CustomGroupChannel.ViewConverter.Header {
    struct typingStatusView: View {
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
            if let channelURL = viewModel.groupChannel?.channelURL {
                GroupChannelView(
                    channelURL: channelURL,
                    headerItem: {
                        .init()
                        .typingStatusView { config  in
                            let overlayColor = self.customFlag ? Color.indigo : Color.cyan
                            // The actual code that works can be implemented using commented conditional statements.
                            //                        if config.channel.isTyping() {
                            Text("typing...")
                                .font(.system(size: 12))
                                .background(overlayColor)
                            //                        } else {
                            //                            EmptyView()
                            //                        }
                        }
                    }
                )
                CustomButton()
            }
        }
    }
}

#Preview {
    CustomGroupChannel.ViewConverter.Header.typingStatusView()
}
