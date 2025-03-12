import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomGroupChannel.ViewConverter.List {
    struct quotedMultipleFilesMessageView: View {
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
                        .quotedMultipleFilesMessageView { config in
                            let overlayColor = self.customFlag ? Color.indigo : Color.cyan
                            
                            ZStack {
                                if let firstFileURL = config.message.files.first?.url {
                                    AsyncImage(url: URL(string: firstFileURL)) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: config.thumbnailSize.width, height: config.thumbnailSize.height)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: config.thumbnailSize.width, height: config.thumbnailSize.height)
                                }
                                
                                
                                // Add overlay color for testing
                                overlayColor.opacity(0.3)
                                    .frame(width: 156, height: 104)
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
