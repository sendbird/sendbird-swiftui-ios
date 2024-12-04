import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomGroupChannelSettings.ViewConverter.List {
    struct leaveChannel: View {
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
            GroupChannelSettingsView(
                provider: GroupChannelSettingsViewProvider(channelURL: TestURL.leaveGroupChannel),
                listItem: {
                    .init()
                    .leaveChannelRow { config in
                        HStack {
                            Text("Title: \(config.title)")
                            
                            Spacer()
                            
                            Text("\(self.customFlag ? "ON" : "OFF")")
                        }
                        .padding()
                    }
                }
            )
            
            CustomButton()
        }
    }
}

#Preview {
    CustomGroupChannelSettings.ViewConverter.List.leaveChannel()
}
