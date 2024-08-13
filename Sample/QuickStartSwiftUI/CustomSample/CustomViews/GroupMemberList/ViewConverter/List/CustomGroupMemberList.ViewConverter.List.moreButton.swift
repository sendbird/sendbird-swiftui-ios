import SwiftUI

extension CustomGroupMemberList.ViewConverter.List {
    struct moreButton: View {
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
                GroupMemberListView(
                    channelURL: channelURL,
                    listItem: {
                        .init()
                        .moreButton { config in
                            if config.isOperatorMode {
                                Circle()
                                    .foregroundStyle(.green)
                                    .frame(width: customFlag ? config.buttonWidth / 2 : config.buttonWidth)
                                    .shadow(radius: 10)
                            } else {
                                EmptyView()
                            }
                        }
                    }
                )
                CustomButton()
            }
        }
    }
}
 
#Preview {
    CustomGroupMemberList.ViewConverter.List.moreButton()
}
