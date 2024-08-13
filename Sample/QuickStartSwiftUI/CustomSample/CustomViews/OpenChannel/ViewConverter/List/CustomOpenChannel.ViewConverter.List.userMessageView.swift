import SwiftUI

extension CustomOpenChannel.ViewConverter.List {
    struct userMessageView: View {
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
                        .userMessageView { config in
                            HStack {
                                Text(config.message.message)
                                    .frame(maxWidth: config.maxWidth, alignment: .leading)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 4)
                                    .foregroundStyle(customFlag ? .green : .red)
                                    .background(
                                        RoundedRectangle(cornerRadius: 14)
                                            .fill(Color.indigo)
                                    )
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
    CustomOpenChannel.ViewConverter.List.userMessageView()
}
