import SwiftUI

extension CustomOpenChannelList.ViewConverter.List {
    struct rowView: View {
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
                    .rowView { config in
                        VStack {
                            Text("List row \(customFlag ? "ON" : "OFF")")
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
    CustomOpenChannelList.ViewConverter.List.rowView()
}
