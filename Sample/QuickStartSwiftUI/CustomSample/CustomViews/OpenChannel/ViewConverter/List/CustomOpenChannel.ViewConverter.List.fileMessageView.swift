import SwiftUI

extension CustomOpenChannel.ViewConverter.List {
    struct fileMessageView: View {
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
                        .fileMessageView { config in
                            switch SBUUtils.getFileType(by: config.message) {
                            case .image, .video:
                                let overlayColor = self.customFlag ? Color.indigo : Color.cyan
                                
                                ZStack {
                                    AsyncImage(url: URL(string: config.message.url)) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: config.thumbnailSize.width, height: config.thumbnailSize.height)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: config.thumbnailSize.width, height: config.thumbnailSize.height)
                                    
                                    // Add overlay color for testing
                                    overlayColor.opacity(0.3)
                                        .frame(width: config.thumbnailSize.width, height: config.thumbnailSize.height)
                                }
                            case .audio, .pdf, .etc:
                                Text("audio, pdf, etc")
                            case .voice:
                                Text("voice")
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
    CustomOpenChannel.ViewConverter.List.fileMessageView()
}
