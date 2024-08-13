import SwiftUI

extension CustomOpenChannelList.ViewConverter.List {
    struct channelPreview: View {
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
                    .channelPreview { config in
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
    CustomOpenChannelList.ViewConverter.List.channelPreview()
}
