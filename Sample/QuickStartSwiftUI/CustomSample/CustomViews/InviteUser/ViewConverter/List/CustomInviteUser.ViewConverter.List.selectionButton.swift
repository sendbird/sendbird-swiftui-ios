import SwiftUI

extension CustomInviteUser.ViewConverter.List {
    struct selectionButton: View {
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
                InviteUserView(
                    channelURL: channelURL,
                    listItem: {
                        .init()
                        .selectionButton { config in
                            Circle()
                                .foregroundStyle(config.isChecked ? .green : .red)
                                .frame(width: customFlag ? config.buttonSize.width / 2 : config.buttonSize.width)
                                .shadow(radius: 10)
                        }
                    }
                )
                CustomButton()
            }
        }
    }
}

#Preview {
    CustomInviteUser.ViewConverter.List.selectionButton()
}
