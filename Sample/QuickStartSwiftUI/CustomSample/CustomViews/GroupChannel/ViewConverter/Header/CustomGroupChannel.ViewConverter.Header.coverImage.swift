import SwiftUI

extension CustomGroupChannel.ViewConverter.Header {
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
            if let channelURL = viewModel.groupChannel?.channelURL {
                GroupChannelView(
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
    CustomGroupChannel.ViewConverter.Header.coverImage()
}
