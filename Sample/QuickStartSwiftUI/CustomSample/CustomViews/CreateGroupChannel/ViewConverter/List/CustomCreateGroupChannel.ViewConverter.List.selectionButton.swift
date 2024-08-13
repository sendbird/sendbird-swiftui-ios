import SwiftUI

extension CustomCreateGroupChannel.ViewConverter.List {
    struct selectionButton: View {
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
                listItem: {
                    .init()
                    .selectionButton { config in
                        Circle()
                            .foregroundStyle(config.isChecked ? .green : .red)
                            .frame(width: customFlag ? config.buttonSize.width/2 : config.buttonSize.width)
                            .shadow(radius: 10)
                    }
                }
            )
            CustomButton()
        }
    }
}

#Preview {
    CustomCreateGroupChannel.ViewConverter.List.selectionButton()
}
