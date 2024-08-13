import SwiftUI
extension CustomGroupChannel.ViewConverter.Input {
    struct leftView: View {
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
            if let channelURL = viewModel.groupChannel?.channelURL {
                GroupChannelView(
                    channelURL: channelURL,
                    inputItem: {
                        .init()
                        .leftView { viewConfig in
                            HStack {
                                Button {
                                    // custom action
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
                                
                                Button {
                                    
                                } label: {
                                    VStack {
                                        Image(systemName: "video.circle")
                                            .resizable()
                                            .frame(width: 24, height: 24)
                                            .foregroundStyle(getColor(viewConfig: viewConfig))
                                            .background(
                                                Circle()
                                                    .frame(width: 26)
                                                    .foregroundStyle(customFlag ? .green.opacity(0.3) : .red.opacity(0.3))
                                            )
                                    }
                                    .frame(height: viewConfig.buttonSize.height)
                                    
                                }
                            }
                        }
                    })
                CustomButton()
            }
        }
        
        func getColor(viewConfig: GroupChannelType.InputItem.MessageInputViewContent.LeftView.ViewConfig) -> Color {
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
    CustomGroupChannel.ViewConverter.Input.leftView()
}
