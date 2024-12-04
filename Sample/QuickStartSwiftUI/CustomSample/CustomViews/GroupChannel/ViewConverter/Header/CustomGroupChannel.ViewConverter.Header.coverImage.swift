import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

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
                    provider: GroupChannelViewProvider(channelURL: channelURL),
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
