import SwiftUI

extension CustomGroupChannelList.SwiftUI.View {
    struct CustomMain: View {
        @State var customFlag: Bool = false
        
        func CustomButton() -> Button<some View> {
            return Button {
                self.customFlag.toggle()
            } label: {
                Text("Update")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
            }
        }
        
        var body: some View {
            ZStack {
                GroupChannelListView(
                    headerItem: {
                        .init()
                        .titleView { config in
                            let borderColor = self.customFlag
                            ? ColorSet.primaryLight
                            : ColorSet.secondaryLight
                            let channelName = self.customFlag
                            ? "Channel list"
                            : "Chat List"
                            Text(channelName)
                                .font(.headline)
                                .padding(3)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(borderColor, lineWidth: 2)
                                    )
                        }
                        .rightView { config in
                            let color = self.customFlag
                            ? ColorSet.primaryLight
                            : ColorSet.secondaryLight
                            let imageName = self.customFlag
                            ? "person.crop.circle.badge.plus"
                            : "plus.message.fill"
                            Image(systemName: imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 30)
                                .blendMode(.normal)
                                .foregroundStyle(color)
                        }
                        .leftView { config in
                            let color = self.customFlag
                            ? ColorSet.primaryLight
                            : ColorSet.secondaryLight
                            let imageName = self.customFlag
                            ? "arrow.backward"
                            : "xmark"
                            Image(systemName: imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 30)
                                .blendMode(.normal)
                                .foregroundStyle(color)
                        }
                    },
                    listItem: {
                        .init()
                        .channelName { config in
                            let borderColor = self.customFlag
                            ? ColorSet.primaryLight
                            : ColorSet.secondaryLight
                            let channelName = self.customFlag
                            ? "Channel type: \(config.channel.channelType.rawValue)"
                            : config.channelName
                            Text(channelName)
                                .frame(maxWidth: 200)
                                .font(.title3)
                                .padding(3)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(borderColor, lineWidth: 2)
                                )
                        }
                        .channelPreview { config in
                            let borderColor = self.customFlag
                            ? ColorSet.primaryExtraLight
                            : ColorSet.secondaryExtraLight
                            let previewMsg = self.customFlag
                            ? "mId: \(config.channel.lastMessage?.messageId ?? -1)"
                            : config.previewMessage
                            Text(previewMsg)
                                .font(.caption)
                                .padding(3)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(borderColor, lineWidth: 2)
                                )
                        }
                        .coverImage { config in
                            let borderColor = self.customFlag
                            ? ColorSet.primaryLight
                            : ColorSet.secondaryLight
                            let imageName = self.customFlag
                            ? "info.square.fill"
                            : "person.2.fill"
                            Image(systemName: imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: config.imageSize.width, height: config.imageSize.height)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(borderColor, lineWidth: 4))
                                .shadow(radius: 10)
                        }
                        .unreadCount { config in
                            let color = self.customFlag
                            ? ColorSet.primaryLight
                            : ColorSet.secondaryLight
                            Text("\(config.unreadCount)")
                                .font(.caption)
                                .padding(5)
                                .background(color)
                                .clipShape(Circle())
                                .foregroundColor(.white)
                        }
                    }
                )
                VStack {
                    Spacer()
                    CustomButton()
                        .padding()
                }
            }
        }
    }
}

#Preview {
    CustomGroupChannelList.SwiftUI.View.CustomMain()
}
