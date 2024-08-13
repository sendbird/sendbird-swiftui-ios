import SwiftUI
extension CustomOpenChannelSettings.SwiftUI.View {
    struct CustomMain: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        @State var customFlag: Bool = false
        
        var body: some View {
            if let channelURL = viewModel.openChannel?.channelURL {
                OpenChannelSettingsView(
                    channelURL: channelURL,
                    headerItem: {
                        .init()
                        .leftView { config in
                            Text("Left \(customFlag ? "ON" : "OFF")")
                                .foregroundStyle(.blue)
                        }
                        .rightView { config in
                            Text("Right \(customFlag ? "ON" : "OFF")")
                                .foregroundStyle(.blue)
                        }
                        .titleView { config in
                            Text("Header Title \(customFlag ? "ON" : "OFF")")
                        }
                    }
                )
                
                CustomButton()
            }
        }
        
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
    }
}

#Preview {
    CustomOpenChannelSettings.SwiftUI.View.CustomMain()
}
