import SwiftUI

extension CustomOpenChannelList.SwiftUI.View {
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
            OpenChannelListView(
                headerItem: {
                    .init()
                    .leftView { config in
                        Text("Left \(customFlag ? "ON" : "OFF")")
                            .foregroundStyle(.blue)
                    }
                    .rightView { config in
                        Text("Right \(customFlag ? "ON" : "OFF")")
                            .foregroundStyle(.blue)
                    }
                    .titleView { config in
                        Text("Header Title \(customFlag ? "ON" : "OFF")")
                    }
                },
                listItem: {
                    .init()
                    .channelName { config in
                        VStack(alignment: .leading) {
                            Text("\(customFlag ? "ON" : "OFF") \(config.channel.name)")
                            Text("Multiline")
                        }
                    }
                    .channelPreview { config in
                        HStack {
                            Text("\(customFlag ? "ON" : "OFF")")
                            Text("  I'm Preview")
                        }
                    }
                    .coverImage { config in
                        Circle()
                            .frame(width: 30, height: 30)
                            .foregroundStyle(customFlag ? .green : .red)
                    }
                }
            )
            CustomButton()
        }
    }
}

#Preview {
    CustomOpenChannelList.SwiftUI.View.CustomMain()
}
