import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomGroupChannel.ViewConverter.List {
    struct quotedFileMessageView: View {
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
                    listItem: {
                        .init()
                        .quotedFileMessageView { config in
                            switch SBUUtils.getFileType(by: config.message) {
                            case .image:
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
                            case .video:
                                Text("video")
                                    .padding()
                            case .audio, .pdf, .etc:
                                Text("audio, pdf, etc")
                                    .padding()
                            case .voice:
                                Text("voice")
                                    .padding()
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
    CustomGroupChannel.ViewConverter.List.quotedFileMessageView()
}
