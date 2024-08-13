import SwiftUI

extension CustomCreateGroupChannel.ViewConverter.List {
    struct entireView: View {
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
                list: { config in
                    List(config.users, id: \.self) { user in
                        Button {
                            config.parentView.onSelectUser(user)
                        } label: {
                            HStack {
                                Circle()
                                    .frame(width: 12, height: 12)
                                    .foregroundStyle(config.selectedUsers.contains(user) ? .green : .red)
                                Text("\(user.refinedNickname()) - \(customFlag ? "ON" : "OFF")")
                                    .foregroundStyle(.black)
                            }
                            .contentShape(Rectangle()) // HStack 전체를 터치 가능한 영역으로 확장
                        }
                    }
                }
            )
            CustomButton()
        }
    }
}

#Preview {
    CustomCreateGroupChannel.ViewConverter.List.entireView()
}
