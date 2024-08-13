import SwiftUI

extension CustomCreateGroupChannel.ViewConverter.Header {
    struct rightView: View {
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
            CreateGroupChannelView(
                headerItem: {
                    .init()
                    .rightView { config in
                        Text("Right \(customFlag ? "ON" : "OFF"): \(config.selectedUserList.count)")
                            .foregroundStyle(.blue)
                    }
                }
            )
            CustomButton()
        }
    }
}

#Preview {
    CustomCreateGroupChannel.ViewConverter.Header.rightView()
}
