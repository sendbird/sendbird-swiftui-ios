import SwiftUI

extension CustomGroupChannelSettings.ViewConverter.List {
    struct searchItem: View {
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
                        .searchRow { config in
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
}

#Preview {
    CustomGroupChannelSettings.ViewConverter.List.searchItem()
}
