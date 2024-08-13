import SwiftUI

extension CustomOpenChannel.ViewConverter.List {
    struct senderProfileImage: View {
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
                    listItem: {
                        .init()
                        .senderProfileImage { config in
                            let overlayColor = self.customFlag ? Color.white : Color.cyan
                            
                            AsyncImage(url: URL(string: config.profileURL)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: config.imageSize.width, height: config.imageSize.height)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(overlayColor, lineWidth: 4))
                                    .shadow(radius: 10)
                            } placeholder: {
                                ProgressView()
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
    CustomOpenChannel.ViewConverter.List.senderProfileImage()
}
