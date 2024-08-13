import SwiftUI

extension CustomGroupChannelList.ViewConverter.List {
    struct entireView: View {
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
                list: { config in
                    ScrollView {
                        ForEach(config.channels) { channel in
                            VStack {
                                Text("Channel entire view: \(customFlag ? "ON" : "OFF")")
                                Text("\(channel.name)")
                            }
                        }
                    }
                }
            )
            
            CustomButton()
        }
    }
}

#Preview {
    CustomGroupChannelList.ViewConverter.List.entireView()
}
