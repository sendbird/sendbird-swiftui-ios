import SwiftUI

extension CustomOpenModerations.ViewConverter.Header {
    struct titleView: View {
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
            if let channelURL = viewModel.openChannel?.channelURL {
                OpenModerationsView(
                    channelURL: channelURL,
                    headerItem: {
                        .init()
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
    CustomOpenModerations.ViewConverter.Header.titleView()
}
