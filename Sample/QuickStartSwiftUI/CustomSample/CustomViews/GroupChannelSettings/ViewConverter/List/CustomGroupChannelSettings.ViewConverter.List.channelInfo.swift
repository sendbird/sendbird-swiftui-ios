import SwiftUI

extension CustomGroupChannelSettings.ViewConverter.List {
    struct channelInfo: View {
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
                    channelURL: channelURL,
                    listItem: {
                        .init()
                        .channelInfo { config in
                            VStack {
                                AsyncImage(url: URL(string: config.channel.coverURL ?? ""))
                                
                                Text("Title: \(config.channel.name.isEmpty ? "None" : config.channel.name)" )
                                Text("\(self.customFlag ? "ON" : "OFF")")
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
    CustomGroupChannelSettings.ViewConverter.List.channelInfo()
}
