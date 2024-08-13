import SwiftUI

extension CustomGroupMutedMemberList.ViewConverter.Header {
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
                GroupMutedMemberListView(
                    channelURL: channelURL,
                    headerItem: {
                        .init()
                        .rightView { config in
                            Text("Right \(customFlag ? "ON" : "OFF")")
                                .foregroundStyle(.blue)
                        }
                    }
                )
                CustomButton()
            }
        }
    }
}
 
#Preview {
    CustomGroupMutedMemberList.ViewConverter.Header.rightView()
}
