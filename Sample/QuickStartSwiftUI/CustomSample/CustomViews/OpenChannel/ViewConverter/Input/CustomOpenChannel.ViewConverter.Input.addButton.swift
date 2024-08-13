import SwiftUI

extension CustomOpenChannel.ViewConverter.Input {
    struct addButton: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        @State var customFlag: Bool = true
        
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
                    inputItem: {
                        .init()
                        .addButton { viewConfig in
                            Button {
                                // default action is automatically applied
                            } label: {
                                VStack {
                                    Image(systemName: "plus.circle")
                                        .resizable()
                                        .frame(
                                            width: viewConfig.buttonSize.width,
                                            height: viewConfig.buttonSize.width
                                        )
                                        .foregroundStyle(getColor(viewConfig: viewConfig))
                                        .background(
                                            Circle()
                                                .frame(width: viewConfig.buttonSize.width)
                                                .foregroundStyle(customFlag ? .green.opacity(0.3) : .red.opacity(0.3))
                                        )
                                }
                                .frame(height: viewConfig.buttonSize.height)
                            }
                        }
                    }
                )
                CustomButton()
            }
        }
        
        func getColor(viewConfig: OpenChannelType.InputItem.MessageInputViewContent.LeftView.AddButton.ViewConfig) -> Color {
            if viewConfig.isFrozen {
                return .red
            } else if viewConfig.isMuted {
                return .gray
            } else {
                return .green
            }
        }
    }
}

#Preview {
    CustomOpenChannel.ViewConverter.Input.addButton()
}
