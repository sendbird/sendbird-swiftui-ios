import SwiftUI

extension CustomOpenChannel.ViewConverter.Header {
    struct coverImage: View {
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
                        .coverImage { config in
                            Circle()
                                .frame(
                                    width: config.imageSize.width,
                                    height: config.imageSize.height
                                )
                                .foregroundStyle(customFlag ? .green : .red)
                        }
                    }
                )
                CustomButton()
            }
        }
    }
}

#Preview {
    CustomOpenChannel.ViewConverter.Header.coverImage()
}
