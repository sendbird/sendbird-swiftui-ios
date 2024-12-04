import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomGroupChannelSettings.ViewConverter.List {
    struct notification: View {
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
                    provider: GroupChannelSettingsViewProvider(channelURL: channelURL),
                    listItem: {
                        .init()
                        .notificationRow { config in
                            HStack {
                                Text("Title: \(config.title)")
                                Text("Noti status: \(config.pushTriggerOption.rawValue)")
                                
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
}

#Preview {
    CustomGroupChannelSettings.ViewConverter.List.notification()
}
