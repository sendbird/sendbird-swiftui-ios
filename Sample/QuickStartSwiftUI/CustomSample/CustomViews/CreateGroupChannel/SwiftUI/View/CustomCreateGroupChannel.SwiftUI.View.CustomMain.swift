import SwiftUI

extension CustomCreateGroupChannel.SwiftUI.View {
    struct CustomMain: View {
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
            CreateGroupChannelView(
                headerItem: {
                    .init()
                    .titleView { config in
                        Text("Header Title \(customFlag ? "ON" : "OFF")")
                    }
                    .leftView { config in
                        Text("Left \(customFlag ? "ON" : "OFF")")
                            .foregroundStyle(.blue)
                    }
                    .rightView { config in
                        Text("Right \(customFlag ? "ON" : "OFF"): \(config.selectedUserList.count)")
                            .foregroundStyle(.blue)
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
                    .selectionButton { config in
                        Circle()
                            .foregroundStyle(config.isChecked ? .green : .red)
                            .frame(width: customFlag ? config.buttonSize.width/2 : config.buttonSize.width)
                            .shadow(radius: 10)
                    }
                    .userName { config in
                        HStack {
                            Text(config.nickname)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 4)
                                .foregroundStyle(customFlag ? .green : .red)
                                .background(
                                    RoundedRectangle(cornerRadius: 14)
                                        .fill(Color.indigo)
                                )
                        }
                    }
                }
            )
            
            CustomButton()
        }
    }
}

#Preview {
    CustomCreateGroupChannel.SwiftUI.View.CustomMain()
}
