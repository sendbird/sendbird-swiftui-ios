import SwiftUI
extension CustomGroupChannelPushSettings.SwiftUI.View {
    struct CustomMain: View {
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
                // Currently only header is tested
                GroupChannelPushSettingsView(
                    channelURL: channelURL,
                    headerItem: {
                        .init()
                        .leftView { config in
                            Text("left \(customFlag ? "ON" : "OFF")")
                                .foregroundStyle(.blue)
                        }
                        .rightView{ config in
                            Text("right \(customFlag ? "ON" : "OFF")")
                        }
                        .titleView { config in
                            Text("Header Title \(customFlag ? "ON" : "OFF")")
                        }
                    }
                )
                
                CustomButton()
            }
        }
    }
}

#Preview {
    CustomGroupChannelPushSettings.SwiftUI.View.CustomMain()
}
