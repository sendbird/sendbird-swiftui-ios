import SwiftUI

extension CustomGroupChannelSettings.ViewConverter.List {
    struct entireView: View {
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
                    list: { config in
                        VStack {
                            Text(config.channel.name.replaceWhenIsEmpty())
                            Text("\(config.channel.memberCount)")
                            Text("Flag: \(customFlag ? "ON" : "OFF")")
                        }
                    }
                )
                
                CustomButton()
            }
        }
    }
}

#Preview {
    CustomGroupChannelSettings.ViewConverter.List.entireView()
}

extension String {
    func replaceWhenIsEmpty() -> String {
        return self.isEmpty ? "None" : self
    }
}
