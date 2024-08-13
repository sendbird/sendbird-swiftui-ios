import SwiftUI

extension CustomGroupChannelSettings.SwiftUI.View {
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
                GroupChannelSettingsView(
                    channelURL: channelURL) {
                        .init()
                        .leftView { viewConfig in
                            Image(systemName: "arrowshape.backward.circle")
                                .resizable()
                                .frame(width: 28, height: 28)
                                .foregroundStyle(customFlag ? .blue : .pink)
                        }
                        .titleView { viewConfig in
                            HStack {
                                Image(systemName: "gear")
                                    .frame(width: 16, height: 16)
                                    .foregroundStyle(customFlag ? .blue : .pink)
                                Text("My Settings")
                                Image(systemName: "gear")
                                    .frame(width: 16, height: 16)
                                    .foregroundStyle(customFlag ? .blue : .pink)
                            }
                        }
                        .rightView { viewConfig in
                            Image(systemName: "slider.horizontal.3")
                                .resizable()
                                .frame(width: 28, height: 28)
                                .foregroundStyle(customFlag ? .blue : .pink)
                        }
                    } listItem: {
                        .init()
                        .channelInfo { viewConfig in
                            HStack {
                                Spacer()
                                VStack(alignment: .center) {
                                    if let coverURL = viewConfig.channel.coverURL {
                                        AsyncImage(url: URL(string: coverURL)) { image in
                                            image
                                                .resizable()
                                                .frame(width: 80, height: 80)
                                                .clipShape(Circle())
                                        } placeholder: {
                                            Circle()
                                                .frame(width: 80, height: 80)
                                                .foregroundStyle(.pink)
                                        }
                                    } else {
                                        Circle()
                                            .frame(width: 80, height: 80)
                                            .foregroundStyle(.pink)
                                    }
                                    
                                    Text(viewConfig.channel.name.isEmpty ?
                                         viewConfig.channel.channelURL :
                                            viewConfig.channel.name )
                                    Text("\(viewConfig.channel.members.count) members")
                                }
                                .padding()
                                .background(Color.pink.opacity(0.1))
                                Spacer()
                            }
                        }
                        .moderationRow(content: { viewConfig in
                            SettingsItemView(itemName: viewConfig.title)
                        })
                        .leaveChannelRow { viewConfig in
                            EmptyView()
                            
                        }
                        .notificationRow { viewConfig in
                            EmptyView()
                        }
                        .memberRow { viewConfig in
                            SettingsItemView(itemName: viewConfig.title)
                        }
                        
                    }
                CustomButton()
            }
        }
    }
    
    struct ItemViewConfigType {
        static let moderation = GroupChannelSettingsType.ListItem.ListItemContent.SettingCell.Moderation.ViewConfig.self
        static let leave = GroupChannelSettingsType.ListItem.ListItemContent.SettingCell.LeaveChannel.ViewConfig.self
    }
    
    struct SettingsItemView: View {
        var itemName: String
//        var moderationViewConfig: GroupChannelSettingsType.ListItem.ListItemContent.SettingCell.Moderation.ViewConfig
        
        
        var body: some View {
            HStack {
                HStack {
                    // icon
                    SettingsItemIcon()
                    
                    // label
                    Text(itemName)
                }
                .padding(.horizontal, 16)
                
                Spacer()
                
                // icon
            }
        }
    }
    
    struct SettingsItemIcon: View {
        var body: some View {
            Image(systemName: "command.circle")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundStyle(.pink)
        }
    }
}

#Preview {
    CustomGroupChannelSettings.SwiftUI.View.CustomMain()
}
