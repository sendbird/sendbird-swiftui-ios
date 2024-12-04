//
//  CustomGroupChannel.SwiftUI.View.ViewProvider.swift
//
//  Created by Celine Moon on 11/14/24.
//

import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif
import SendbirdChatSDK

extension CustomGroupChannel.SwiftUI.View {
    struct ViewProvider: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        @StateObject var provider = GroupChannelViewProvider(channelURL: "")
        @State private var showingMessageTextAlert = false
        
        var body: some View {
            VStack {
                GroupChannelView(provider: provider)
                    .onAppear {
                        if let channelURL = viewModel.groupChannel?.channelURL {
                            provider.setup(channelURL: channelURL)
                        }
                    }

                VStack {
                    // Demo of @Published properties
                    Text("Number of loaded messages: \(provider.fullMessages.count)")
                        .padding()
                        .background(Color.blue.opacity(0.5))
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .font(.system(size: 13))
                    
                    
                    // Demo of provider methods.
                    Button {
                        if let messageText = provider.messageInputText {
                            let trimmedText = messageText.trimmingCharacters(in: .whitespacesAndNewlines)
                            guard trimmedText.isEmpty == false else {
                                showingMessageTextAlert = true
                                return
                            }
                            let messageParam = UserMessageCreateParams(message: trimmedText)
                            provider.sendUserMessage(messageParams: messageParam)
                            provider.endTypingMode()
                            provider.messageInputText = nil
                        } else {
                            showingMessageTextAlert = true
                        }
                    } label: {
                        Text("Send User Message")
                            .padding()
                            .background(Color.yellow.opacity(0.5))
                            .foregroundColor(.black)
                            .cornerRadius(10)
                            .font(.system(size: 13))
                    }
                    .alert(isPresented: $showingMessageTextAlert) {
                        Alert(
                            title: Text("Empty message"),
                            message: Text("Type in message text to send a User Message"),
                            dismissButton: .default(Text("Dismiss"))
                        )
                    }
                    
                    Button {
                        provider.showPhotosLibrary()
                    } label: {
                        Text("Show Photos and Send File Message")
                            .padding()
                            .background(Color.yellow.opacity(0.5))
                            .foregroundColor(.black)
                            .cornerRadius(10)
                            .font(.system(size: 13))
                    }
                }
            }
        }
    }
}
