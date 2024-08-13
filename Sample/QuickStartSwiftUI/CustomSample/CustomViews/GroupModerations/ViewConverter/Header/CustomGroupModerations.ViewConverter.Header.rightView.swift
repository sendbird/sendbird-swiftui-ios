import SwiftUI

extension CustomGroupModerations.ViewConverter.Header {
    struct rightView: View {
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
                GroupModerationsView(
                    channelURL: channelURL,
                    headerItem: {
                        .init()
                        .rightView { config in
                            // TODO: SwiftUI - 구현 필요할지 체크 필요 (원래 없는 액션)
                            Text("Right \(customFlag ? "ON" : "OFF")")
                        }
                    }
                )
                CustomButton()
            }
        }
    }
}

#Preview {
    CustomGroupModerations.ViewConverter.Header.rightView()
}
