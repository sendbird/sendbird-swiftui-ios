import SwiftUI

extension CustomGroupMemberList.ViewConverter.List {
    struct entireView: View {
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
                    list: { config in
                        List(config.users, id: \.self) { user in
                            HStack {
                                Circle()
                                    .frame(width: 12, height: 12)
                                    .foregroundStyle(user.isOperator ? .green : .red)
                                Text("\(user.refinedNickname()) - \(customFlag ? "ON" : "OFF")")
                                    .foregroundStyle(.black)
                            }
                            .contentShape(Rectangle()) // HStack 전체를 터치 가능한 영역으로 확장
                        }
                    }
                )
                CustomButton()
            }
        }
    }
}
 
#Preview {
    CustomGroupMemberList.ViewConverter.List.entireView()
}
