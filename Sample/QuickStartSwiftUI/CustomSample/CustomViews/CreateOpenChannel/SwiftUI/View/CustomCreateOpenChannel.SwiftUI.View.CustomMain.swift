import SwiftUI

extension CustomCreateOpenChannel.SwiftUI.View {
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
            CreateOpenChannelView(
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
}

#Preview {
    CustomCreateOpenChannel.SwiftUI.View.CustomMain()
}
