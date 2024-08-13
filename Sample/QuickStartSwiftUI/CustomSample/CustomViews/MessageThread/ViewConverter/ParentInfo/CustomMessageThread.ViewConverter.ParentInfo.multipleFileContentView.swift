import SwiftUI

extension CustomMessageThread.ViewConverter.ParentInfo {
    struct multipleFileContentView: View {
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
                    parentInfoItem: {
                        .init()
                        .multipleFilesContentView { config  in
                            LazyVGrid(
                                columns: Array(repeating: GridItem(.fixed(config.thumbnailSize.width), spacing: 2), count: 2),
                                spacing: 2
                            ) {
                                ForEach(config.multipleFilesMessage.files, id: \.self) { file in
                                    Rectangle()
                                        .frame(width: config.thumbnailSize.width, height: config.thumbnailSize.height)
                                        .foregroundStyle(customFlag ? Color.indigo : .red)
                                }
                            }
                            .frame(maxWidth: config.maxWidth, alignment: .leading)
                            .padding(2)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.yellow)
                            )
                        }
                    }
                )
                
                CustomButton()
            }
        }
    }
}

#Preview {
    CustomMessageThread.ViewConverter.ParentInfo.multipleFileContentView()
}
