import SwiftUI
extension CustomInviteUser.SwiftUI.View {
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
            if let channelURL = viewModel.groupChannel?.channelURL {
                InviteUserView(
                    channelURL: channelURL,
                    headerItem: {
                        .init()
                        .leftView { config in
                            Text("Left \(customFlag ? "ON" : "OFF")")
                                .foregroundStyle(.blue)
                        }
                        .rightView { config in
                            Text("Right \(customFlag ? "ON" : "OFF"): \(config.selectedUserList.count)")
                                .foregroundStyle(.blue)
                        }
                        .titleView { config in
                            Text("Header Title \(customFlag ? "ON" : "OFF")")
                        }
                    },
                    listItem: {
                        .init()
                        .profileImage { config in
                            let overlayColor = self.customFlag ? Color.white : Color.cyan
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
                    }
                )
                
                CustomButton()
            }
        }
    }
}

#Preview {
    CustomInviteUser.SwiftUI.View.CustomMain()
}
