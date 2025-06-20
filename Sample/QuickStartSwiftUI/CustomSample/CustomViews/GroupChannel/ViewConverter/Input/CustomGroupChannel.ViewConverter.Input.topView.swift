import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif
import SendbirdChatSDK

extension CustomGroupChannel.ViewConverter.Input {
    struct topView: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        @StateObject var provider = GroupChannelViewProvider(channelURL: "")
        @State private var showingMessageTextAlert = false
        
        var body: some View {
                GroupChannelView(
                    provider: provider,
                    inputItem: {
                        .init()
                        .topView { viewConfig in
                            let _ = Self._printChanges()
                            VStack {
                                // Suggested Replies View
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        ForEach(0..<5, id: \.self) { number in
                                            Button {
                                                let messageParam = UserMessageCreateParams(message: "predefined message \(number)")
                                                provider.sendUserMessage(messageParams: messageParam)
                                            } label: {
                                                Text("predefined message \(number)")
                                                    .padding(8)
                                                    .background(Color.blue.opacity(0.3))
                                                    .cornerRadius(8)
                                            }
                                            .disabled(viewConfig.isMuted || viewConfig.isFrozen)
                                        }
                                    }
                                    .padding(.horizontal, 16)
                                }
                                .padding(.top, 16)
                                
                                // Show the default QuoteMessageInputView only when `isQuoteReplyingMode` is true.
                                if viewConfig.isQuoteReplyingMode {
                                    QuoteMessageInputView(configuration: viewConfig.quoteMessageInputViewConfiguration)
                                        .frame(height: viewConfig.quoteMessageInputViewHeight)
                                }
                            }
                            .border(Color.red, width: 2)
                        }
                    }
                )
                .onAppear {
                    if let channelURL = viewModel.groupChannel?.channelURL {
                        provider.setup(channelURL: channelURL)
                    }
                }
        }
    }
}

#Preview {
    CustomGroupChannel.ViewConverter.Input.topView()
}
