import SwiftUI

extension CustomGroupChannel.SwiftUI.View {
    struct CustomMain: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.groupChannel?.channelURL {
                GroupChannelView(
                    channelURL: channelURL,
                    headerItem: {
                        .init()
                        .leftView { config in
                            Text("L")
                                .foregroundStyle(.blue)
                        }
                        .coverImage { config in
                            Text("C")
                                .frame(
                                    width: config.imageSize.width,
                                    height: config.imageSize.height
                                )
                                .foregroundColor(.white)
                                .background(.blue)
                        }
                        .rightView { config in
                            Text("R")
                                .foregroundStyle(.blue)
                        }
                        .titleLabel { config in
                            Text("T")
                        }
                        .typingStatusView { config in
                            if config.channel.isTyping() {
                                Text("typing...")
                                    .font(.system(size: 12))
                            } else {
                                EmptyView()
                            }
                        }
                    },
                    listItem: {
                        .init()
                        .adminMessageView { config in
                            VStack {
                                Text("This is admin message.")
                                Text(config.message.message.replaceOnIsEmpty())
                            }
                            .padding()
                            .background(.black.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        }
                        .fileMessageView { config in
                            VStack {
                                Text(String(repeating: "This is file message.", count: 10))
                                Text(config.message.url.replaceOnIsEmpty())
                                // Why it works?
                                // HStack { Spacer() }
                            }
                            .frame(width: config.maxWidth)
                            .padding()
                            .background(.green.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        }
                        .multipleFilesMessageView { config in
                            VStack {
                                ForEach(config.message.files, id: \.self) { file in
                                    Text("This is multiple file message.")
                                    Text(file.url)
                                        .frame(width: config.thumbnailSize.width, height: config.thumbnailSize.height)
                                }
                            }
                            .padding()
                            .background(.pink.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        }
                        .userMessageView { config in
                            VStack {
                                Text(String(repeating: "This is user message.", count: 10))
                                Text(config.message.message.replaceOnIsEmpty())
                            }
                            .frame(width: config.maxWidth)
                            .padding()
                            .background(.blue.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        }
                        .channelStateBanner { config in
                            VStack {
                                Text("This is channelStateBanner.")
                            }
                            .background(.clear)
                        }
                        // Commented for visibility
                        //                        .scrollBottomView { config in
                        //                            VStack {
                        //                                Text("THIS IS LONG")
                        //                                Rectangle().frame(width: 200, height: 200)
                        //                            }
                        //                        }
                        .senderProfileImage { config in
                            VStack {
                                Text("\(config.profileURL)")
                                    .frame(width: config.imageSize.width, height: config.imageSize.height)
                                    .background(Circle().fill(.red))
                            }
                        }
                        .newMessageInfoView { config in
                            Text("New message arrived: \(config.count)")
                                .padding()
                                .background(.blue)
                                .foregroundColor(.white)
                        }
                        .typingIndicatorView { config in
                            // Multiline test
                            VStack {
                                Text("typing... \(config.typingInfo.numberOfTypers)")
                                Text("typing... \(config.typingInfo.numberOfTypers)")
                                Text("typing... \(config.typingInfo.numberOfTypers)")
                            }
                        }
                    },
                    inputItem: {
                        .init()
                        .addButton { config in
                            Text("A")
                                .frame(width: config.buttonSize.width, height: config.buttonSize.height)
                                .foregroundColor(.white)
                                .background(.blue)
                        }
                        .leftView { config in
                            Text("L")
                                .frame(width: config.buttonSize.width, height: config.buttonSize.height)
                                .foregroundColor(.white)
                                .background(.blue)
                        }
                        .voiceButton { config in
                            Text("V")
                                .frame(width: config.buttonSize.width, height: config.buttonSize.height)
                                .foregroundColor(.white)
                                .background(.blue)
                        }
                        //                        .rightView { config in
                        //                            Text("Add")
                        //                                .frame(width: config.buttonSize.width, height: config.buttonSize.height)
                        //                                .foregroundColor(.white)
                        //                                .background(.blue)
                        //                        }
                        .sendButton { config in
                            Text("S")
                                .frame(width: config.buttonSize.width, height: config.buttonSize.height)
                                .foregroundColor(.white)
                                .background(.blue)
                        }
                    }
                )
            }
        }
    }
}

fileprivate extension String {
    func replaceOnIsEmpty() -> String {
        if self.isEmpty {
            return "Empty"
        } else {
            return self
        }
    }
}

#Preview {
    CustomGroupChannel.SwiftUI.View.CustomMain()
}
