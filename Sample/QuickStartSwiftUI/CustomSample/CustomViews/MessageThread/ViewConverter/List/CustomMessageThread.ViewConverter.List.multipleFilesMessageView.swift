import SwiftUI

extension CustomMessageThread.ViewConverter.List {
    struct multipleFilesMessageView: View {
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
                    listItem: {
                        .init()
                        .multipleFilesMessageView { config  in
                            LazyVGrid(columns: Array(repeating: GridItem(.fixed(config.thumbnailSize.width+2)), count: 2)) {
                                ForEach(config.message.files, id: \.self) { file in
                                    Rectangle()
                                        .frame(width: config.thumbnailSize.width, height: config.thumbnailSize.height)
                                        .foregroundStyle(customFlag ? Color.indigo : .red)
                                }
                            }
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
    CustomMessageThread.ViewConverter.List.multipleFilesMessageView()
}
