import SwiftUI

extension CustomGroupMemberList.SwiftUI.View {
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
                // Currently only header is tested
                GroupMemberListView(
                    channelURL: channelURL,
                    headerItem: {
                        .init()
                        .leftView { config in
                            Text("left \(customFlag ? "ON" : "OFF")")
                                .foregroundStyle(.blue)
                        }
                        .rightView{ config in
                            Text("right \(customFlag ? "ON" : "OFF")")
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
                        .moreButton { config in
                            if config.isOperatorMode {
                                Circle()
                                    .foregroundStyle(.green)
                                    .frame(width: customFlag ? config.buttonWidth / 2 : config.buttonWidth)
                                    .shadow(radius: 10)
                            } else {
                                EmptyView()
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
    CustomGroupMemberList.SwiftUI.View.CustomMain()
}
