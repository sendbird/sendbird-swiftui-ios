//
//  LoginView.swift
//  QuickStartSwiftUI
//
//  Created by Celine Moon on 7/11/24.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var appDelegate: AppDelegate
    
    @State var appID = "FEA2129A-EA73-4EB9-9E0B-EC738E7EB768" // default ID
    @State var userID = ""
    @State var nickname = ""
    @State var replyOption: SBUReplyType = .quoteReply
    @State var appearance: Appearance = .light
    
    @State private var showMainView = false
    @State private var showConnectionFailAlert = false
    @State private var connectionFailMessage = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Text("SwiftUI QuickStart")
                    .font(.system(.title, design: .rounded))
                    .bold()
                
                // App ID, user ID, nickname
                TextField("APP ID", text: $appID)
                    .foregroundStyle(.gray)
                    .roundedBackground(color: .white)
                
                TextField("User ID", text: $userID)
                    .roundedBackground(color: .white)
                TextField("Nickname", text: $nickname)
                    .roundedBackground(color: .white)
                
                // Reply option
                HStack {
                    Text("Reply type")
                    Spacer()
                    Picker("Reply type", selection: $replyOption) {
                        Text("Disable Reply").tag(SBUReplyType.none)
                        Text("Quote Reply").tag(SBUReplyType.quoteReply)
                        Text("Message Thread").tag(SBUReplyType.thread)
                    }
                }
                .roundedBackground(color: .white, verticalPadding: 8)
                
                // Light/dark
                HStack {
                    Text("Appearance")
                    Spacer()
                    Picker("Theme", selection: $appearance) {
                        Text("Light").tag(Appearance.light)
                        Text("Dark").tag(Appearance.dark)
                    }
                }
                .roundedBackground(color: .white, verticalPadding: 8)

                // Login button
                Button(action: {
                    guard !userID.isEmpty else { return }
                    if nickname.isEmpty { nickname = userID }
                    print("[QuickStartSwiftUI] Logging in as [userId = \(userID), nickname = \(nickname)]")
                    
                    logIn()
                }, label: {
                    Text("Log In")
                        .frame(maxWidth: .infinity)
                        .roundedBackground(color: self.userID.isEmpty ? .gray.opacity(0.65) : .blue)
                        .foregroundStyle(.white)
                })
                
                NavigationLink(
                    destination: MainView().navigationBarBackButtonHidden(true),
                    isActive: $showMainView) {
                    EmptyView()
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(uiColor: UIColor.secondarySystemBackground))
            .onAppear {
                guard let userID = UserDefaults.loadUserID(),
                      let nickname = UserDefaults.loadNickname() else {
                    // self.userID = ""
                    // self.nickname = ""
                    return
                }
                
                self.userID = userID
                self.nickname = nickname
                logIn()
            }
            .alert(connectionFailMessage, isPresented: $showConnectionFailAlert) {
                Button("OK", role: .cancel) { }
            }
        }
        .navigationViewStyle(.stack)
    }
}

extension LoginView {
    func logIn() {
        setupSendbirdUIConfigs()
        
        guard !self.userID.isEmpty && !self.nickname.isEmpty && !self.appID.isEmpty else {
            print("[QuickStartSwiftUI] Missing userID, nickname, or appID.")
            return
        }
        initializeSendbird()
    }
    
    func setupSendbirdUIConfigs() {
        // Reply option
        SendbirdUI.config.groupChannel.channel.replyType = self.replyOption
        
        // Appearance
        switch self.appearance {
        case .light:
            SBUTheme.set(theme: .light)
        case .dark:
            SBUTheme.set(theme: .dark)
        }
        
        // Other options
        SendbirdUI.config.common.isUsingDefaultUserProfileEnabled = true
        SendbirdUI.config.groupChannel.channel.isMentionEnabled = true
        SendbirdUI.config.groupChannel.channel.isVoiceMessageEnabled = true
        SendbirdUI.config.groupChannel.channelList.isTypingIndicatorEnabled = true
        SendbirdUI.config.groupChannel.channel.isTypingIndicatorEnabled = true
        SendbirdUI.config.groupChannel.channel.typingIndicatorTypes = [.bubble, .text]
        SendbirdUI.config.groupChannel.channel.isFeedbackEnabled = true
        SendbirdUI.config.groupChannel.channel.isFormTypeMessageEnabled = true
        SendbirdUI.config.groupChannel.channel.isSuggestedRepliesEnabled = true
        SendbirdUI.config.groupChannel.channel.isMultipleFilesMessageEnabled = true
        
        SBUGlobals.isImageCompressionEnabled = true
    }
    
    func initializeSendbird() {
        SendbirdUI.setLogLevel(.all)
        SendbirdUI.initialize(
            applicationId: self.appID
        ) { params in
            params?.isLocalCachingEnabled = true
            params?.appVersion = SendbirdUI.versionString()
            params?.needsSynchronous = false
        } startHandler: {
            SBULoading.start()
        } migrationHandler: {
            
        } completionHandler: { _ in
            appDelegate.registerRemoteNotifications()
            SBUGlobals.currentUser = SBUUser(userId: self.userID, nickname: self.nickname)
           
            SendbirdUI.connect { user, error in
                SBULoading.stop()
                
                if let user = user, error == nil {
                    UserDefaults.saveLogInInfo(
                        appId: self.appID,
                        userId: self.userID,
                        nickname: self.nickname
                    )
                    
                    SBUGlobals.currentUser = SBUUser(user: user)
                    print("[QuickStartSwiftUI] ✅ SendbirdUIKit.connect: \(user.userId) (\(user.nickname))")

                    self.showMainView = true
                } else {
                    self.connectionFailMessage = "Failed to connect to Sendbird. \(error!)"
                    self.showConnectionFailAlert = true
                }
            }
        }
    }
    
}

enum Appearance {
    case light
    case dark
}

#Preview {
    LoginView()
}
