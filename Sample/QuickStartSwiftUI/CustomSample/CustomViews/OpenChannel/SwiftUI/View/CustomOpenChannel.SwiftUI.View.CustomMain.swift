import SwiftUI

extension CustomOpenChannel.SwiftUI.View {
    struct CustomMain: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        
        var body: some View {
            if let channelURL = viewModel.openChannel?.channelURL {
                OpenChannelView(
                    channelURL: channelURL,
                    headerItem: {
                        .init()
                        .coverImage { config in
                            Text("cover-image")
                        }
                        .leftView { config in
                            Text("[<]")
                        }
                        .rightView { config in
                            Text("[R]")
                        }
                        .titleLabel { config in
                            Text("title-label")
                                .onTapGesture { debugPrint("title-label") }
                        }
                        .subtitleLabel { config in
                            Text("subtitle-label")
                        }
                    },
                    listItem: {
                        .init()
                        .adminMessageView { config in
                            Text("📣 \(config.message.message)")
                        }
                        .fileMessageView { config in
                            Text("🗳️ \(config.message.message)")
                                .frame(width: config.maxWidth, height: 20)
                                .background(.red)
                        }
                        .scrollBottomView { config in
                            Text("⬇️")
                        }
                        .senderProfileImage { config in
                            Text("😀")
                        }
                        .userMessageView { config in
                            HStack {
                                Spacer()
                                Text("📝 \(config.message.message)")
                                Spacer()
                            }
                        }
                    },
                    inputItem: {
                        .init()
                        .addButton { config in
                            Text("[A]")
                        }
                        .leftView { config in
                            Text("[L]")
                        }
                        .rightView { config in
                            Text("[R]")
                        }
                        .sendButton { config in
                            Text("[>]")
                        }
                    }
                )
            }
        }
    }
}

#Preview {
    CustomOpenChannel.SwiftUI.View.CustomMain()
}
