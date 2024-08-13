import SwiftUI
extension CustomMessageThread.SwiftUI.View {
    struct CustomMain: View {
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
                    channelURL: channelURL, parentMessageId: parentMessageId,
                    headerItem: {
                        .init()
                        .leftView { config in
                            Text("Left \(customFlag ? "ON" : "OFF")")
                                .foregroundStyle(.blue)
                        }
                        .titleLabel { config in
                            Text("Thread")
                        }
                        .subtitleLabel { config in
                            Text("Subtitle goes here")
                        }
                        .rightView { config in
                            Text("Right \(customFlag ? "ON" : "OFF")")
                                .foregroundStyle(.blue)
                        }
                    },
                    parentInfoItem: {
                        .init()
                        .dateLabel { config in
                            Text("date-label")
                                .foregroundStyle(.pink)
                        }
                        .messageTextView { config in
                            Text("messageTextView")
                                .frame(height: 80)
                                .foregroundStyle(.pink)
                                .background(.yellow)
                        }
                        .moreButton { config in
                            Button(action: {
                                config.parentView.onTapMoreButton(())
                            }, label: {
                                Text("><")
                            })
                            .foregroundStyle(.pink)
                        }
                        .profileView { config in
                            Text("profileView")
                                .frame(height: 80)
                                .foregroundStyle(.pink)
                                .background(.yellow)
                        }
                        .reactionView { config in
                            Text("reactionView")
                                .frame(height: 80)
                                .foregroundStyle(.pink)
                                .background(.yellow)
                        }
                        .replyLabel { viewConfig in
                            Text("\(viewConfig.parentMessage.threadInfo.replyCount) replies")
                                .foregroundStyle(.pink)
                        }
                    },
                    listItem: {
                        .init()
                        .userMessageView { config in
                            HStack {
                                Text(config.message.message)
                                    .frame(maxWidth: config.maxWidth, alignment: .leading)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 4)
                                    .foregroundStyle(.pink)
                                    .background(
                                        RoundedRectangle(cornerRadius: 14)
                                            .fill(Color.indigo)
                                    )
                            }
                        }
                        .channelStateBanner { config in
                            HStack {
                                Spacer()
                                Text("Channel state goes here")
                                Spacer()
                            }
                            .background(Color.pink)
                        }
                        .fileMessageView { config in
                            switch SBUUtils.getFileType(by: config.message) {
                            case .image, .video:
                                let overlayColor = Color.pink
                                
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
                        .multipleFilesMessageView { config  in
                            LazyVGrid(columns: Array(repeating: GridItem(.fixed(config.thumbnailSize.width+2)), count: 2)) {
                                ForEach(config.message.files, id: \.self) { file in
                                    Rectangle()
                                        .frame(width: config.thumbnailSize.width, height: config.thumbnailSize.height)
                                        .foregroundStyle(.pink)
                                }
                            }
                            .padding(2)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.yellow)
                            )
                        }
                        .senderProfileImage { config in
                            let overlayColor = Color.pink
                            
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
                    },
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
                                                .foregroundStyle(.pink)
                                        )
                                }
                                .frame(height: viewConfig.buttonSize.height)
                            }
                        }
                        .sendButton { viewConfig in
                            VStack {
                                Image(systemName: "paperplane.circle")
                                    .resizable()
                                    .frame(
                                        width: viewConfig.buttonSize.width,
                                        height: viewConfig.buttonSize.width
                                    )
                                    .foregroundStyle(getColor(viewConfig: viewConfig))
                                    .background(
                                        Circle()
                                            .frame(width: viewConfig.buttonSize.width)
                                            .foregroundStyle(.pink)
                                    )
                            }
                            .frame(height: viewConfig.buttonSize.height)
                        }
                        .voiceButton(content: { viewConfig in
                            VStack {
                                Image(systemName: "mic.circle")
                                    .resizable()
                                    .frame(
                                        width: viewConfig.buttonSize.width,
                                        height: viewConfig.buttonSize.width
                                    )
                                    .foregroundStyle(getColor(viewConfig: viewConfig))
                                    .background(
                                        Circle()
                                            .frame(width: viewConfig.buttonSize.width)
                                            .foregroundStyle(.pink)
                                    )
                            }
                            .frame(height: viewConfig.buttonSize.height)
                        })
                    }
                )
                CustomButton()
            }
        }
        
        func getColor(viewConfig: MessageThreadType.InputItem.MessageInputViewContent.LeftView.AddButton.ViewConfig) -> Color {
            if viewConfig.isFrozen {
                return .red
            } else if viewConfig.isMuted {
                return .gray
            } else {
                return .green
            }
        }
        
        func getColor(viewConfig: MessageThreadType.InputItem.MessageInputViewContent.RightView.SendButton.ViewConfig) -> Color {
            if viewConfig.isFrozen {
                return .red
            } else if viewConfig.isMuted {
                return .gray
            } else {
                return .green
            }
        }
        
        func getColor(viewConfig: MessageThreadType.InputItem.MessageInputViewContent.RightView.VoiceButton.ViewConfig) -> Color {
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
    CustomMessageThread.SwiftUI.View.CustomMain()
}
