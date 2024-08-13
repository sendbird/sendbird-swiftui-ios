import SwiftUI

extension CustomOpenChannelRegisterOperator.SwiftUI.View {
    struct CustomMain: View {
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
            // Currently only header is tested
            OpenChannelRegisterOperatorView(
                channelURL: TestURL.openChannelOperator,
                headerItem: {
                    .init()
                    .leftView { config in
                        Text("left \(customFlag ? "ON" : "OFF")")
                            .foregroundStyle(.blue)
                    }
                    .rightView{ config in
                        Text("right \(customFlag ? "ON" : "OFF")")
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
}

#Preview {
    CustomOpenChannelRegisterOperator.SwiftUI.View.CustomMain()
}
