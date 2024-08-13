//
//  MySettingsView.swift
//  SendbirdUIKit
//
//  Created by Celine Moon on 8/1/24.
//

import SwiftUI
import SendbirdChatSDK

struct MySettingsView: View {
    @State var user: SBUUser? = SBUGlobals.currentUser
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var updatedImage: UIImage?
    @State var doNotDisturb = false
    
    var body: some View {
        VStack {
            Spacer()
            if let currentUser = user {
                Text("My Settings")
                    .font(.system(size: 23, weight: .bold))
                
                // profile image
                ProfileImageView(user: currentUser, updatedImage: updatedImage)
                    .padding(.top, 30)
                
                // edit profile
                Button {
                    self.showImagePicker = true
                } label: {
                    Text("Edit")
                }
                
                // id & nickname
                NameView(
                    user: $user,
                    nickname: currentUser.nickname ?? "no nickname"
                )
                .padding(.top, 30)
                
                // do not disturb
                HStack {
                    Toggle("Do Not Disturb", isOn: $doNotDisturb)
                }
                .roundedBackground(
                    color: Color(uiColor: UIColor.secondarySystemBackground),
                    verticalPadding: 8
                )
                .padding(.top, 30)
                
            } else {
                Text("You must login first.")
            }
            Spacer()
        }
        .padding()
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $selectedImage)
        }
        .task {
            SendbirdChat.getDoNotDisturb { enabled, _, _, _, _, _, _ in
                self.doNotDisturb = enabled
            }
        }
        .onChange(of: selectedImage) { _ in
            updateUserImage()
        }
        .onChange(of: doNotDisturb) { value in
            SendbirdChat.setDoNotDisturb(
                enable: value,
                startHour: 0,
                startMin: 0,
                endHour: 23,
                endMin: 59,
                timezone: "UTC"
            ) { error in
                if let error {
                    self.doNotDisturb = !value
                    return
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(uiColor: UIColor.systemBackground))
        // dismiss keyboard when tapped outside textfield
        .onTapGesture {
            UIApplication.shared.sendAction(
                #selector(UIResponder.resignFirstResponder),
                to: nil,
                from: nil,
                for: nil
            )
        }
    }
    
    func updateUserImage() {
        guard let selectedImage else { return }
        
        // Update server data
        SendbirdUI.updateUserInfo(nickname: nil, profileImage: selectedImage.jpegData(compressionQuality: 0.5)) { error in
            if let error {
                print("Failed to update user image. \(error)")
                return
            }
        
            // Update local data
            self.updatedImage = selectedImage
            self.user = SBUGlobals.currentUser
        }
    }
}

struct ProfileImageView: View {
    var user: SBUUser
    var updatedImage: UIImage?
    
    var body: some View {
        Group {
            if let updatedImage {
                Image(uiImage: updatedImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
            } else if let profileURL = user.profileURL {
                AsyncImage(url: URL(string: profileURL)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                } placeholder: {
                    ProgressView()
                }
            } else {
                Circle()
                    .fill(Color.purple.opacity(0.3))
            }
        }
        .frame(width: 100, height: 100)
        .overlay(Circle().stroke(Color.gray.opacity(0.8), lineWidth: 0.8))
    }
    
}

struct NameView: View {
    @Binding var user: SBUUser?
    @State var nickname: String
    
    var body: some View {
        if let user {
            VStack {
                HStack {
                    Text("ID")
                    Spacer()
                    Text(user.userId)
                }
                .roundedBackground(
                    color: Color(uiColor: UIColor.secondarySystemBackground),
                    verticalPadding: 12
                )
                
                HStack {
                    Text("Nickname")
                    Spacer()
                    TextField("nickname", text: $nickname)
                        .foregroundColor(.blue)
                        .multilineTextAlignment(.trailing)
                        .onSubmit {
                            // Update server data.
                            SendbirdUI.updateUserInfo(nickname: nickname, profileURL: nil) { error in
                                if let error {
                                    print("Failed to update nickname. \(error)")
                                    if let originalNickname = user.nickname {
                                        // show original nickname
                                        self.nickname = originalNickname
                                    }
                                    return
                                }
                                
                                // Update local data.
                                if let user = SBUGlobals.currentUser {
                                    self.user = user
                                }
                                UserDefaults.updateNickname(nickname: nickname)
                            }
                        }
                        .submitLabel(.done)
                }
                .roundedBackground(
                    color: Color(uiColor: UIColor.secondarySystemBackground),
                    verticalPadding: 12
                )
            }
            .frame(maxWidth: .infinity)
        }
    }
}
