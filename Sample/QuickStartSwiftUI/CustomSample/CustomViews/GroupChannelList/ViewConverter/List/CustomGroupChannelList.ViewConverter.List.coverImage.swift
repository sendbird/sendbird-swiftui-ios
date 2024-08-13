import SwiftUI

extension CustomGroupChannelList.ViewConverter.List {
    struct coverImage: View {
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
            GroupChannelListView(
                listItem: {
                    .init()
                    .coverImage { config in
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
    CustomGroupChannelList.ViewConverter.List.coverImage()
}
