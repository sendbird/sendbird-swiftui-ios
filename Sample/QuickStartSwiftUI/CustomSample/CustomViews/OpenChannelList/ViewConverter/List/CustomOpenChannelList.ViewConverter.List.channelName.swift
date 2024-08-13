import SwiftUI

extension CustomOpenChannelList.ViewConverter.List {
    struct channelName: View {
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
                listItem: {
                    .init()
                    .channelName { config in
                        VStack {
                            Text("\(customFlag ? "ON" : "OFF")")
                            Text("\(config.channel.name)")
                        }
                    }
                }
            )
            
            CustomButton()
        }
    }
}

#Preview {
    CustomOpenChannelList.ViewConverter.List.channelName()
}
