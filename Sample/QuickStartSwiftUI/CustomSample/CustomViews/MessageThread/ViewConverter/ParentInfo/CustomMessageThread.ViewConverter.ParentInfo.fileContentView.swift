import SwiftUI

extension CustomMessageThread.ViewConverter.ParentInfo {
    struct fileContentView: View {
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
                        .fileContentView { config in
                            switch SBUUtils.getFileType(by: config.fileMessage) {
                            case .image, .video:
                                Text("image, video")
                                    .foregroundStyle(customFlag ? .green : .red)
                            case .audio, .pdf, .etc:
                                Text("audio, pdf, etc")
                                    .foregroundStyle(customFlag ? .green : .red)
                            case .voice:
                                Text("voice")
                                    .foregroundStyle(customFlag ? .green : .red)
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
    CustomMessageThread.ViewConverter.ParentInfo.fileContentView()
}
