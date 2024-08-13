import SwiftUI

extension CustomCreateOpenChannel.SwiftUI.View {
    struct Main: View {
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
                        Button {
                            print("left button tapped")
                            config.parentView.onTapLeftBarButton()
                        } label: {
                            Text("Left \(customFlag ? "ON" : "OFF")")
                        }
                    }
                }
            )
            CustomButton()
        }
    }
}

#Preview {
    CustomCreateOpenChannel.SwiftUI.View.Main()
}
