import SwiftUI

extension CustomOpenChannel.ViewConverter.Header {
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
            if let channelURL = viewModel.openChannel?.channelURL {
                OpenChannelView(
                    channelURL: channelURL,
                    headerItem: {
                        .init()
                        .subtitleLabel { config  in
                            let overlayColor = self.customFlag ? Color.indigo : Color.cyan
                            Text("[Custom] Participants \(config.participantCount)")
                                .font(.system(size: 12))
                                .background(overlayColor)
                        }
                    }
                )
                CustomButton()
            }
        }
    }
}

#Preview {
    CustomOpenChannel.ViewConverter.Header.subtitleLabel()
}
