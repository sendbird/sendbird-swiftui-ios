import SwiftUI

extension CustomCreateGroupChannel.ViewConverter.List {
    struct userNameLabel: View {
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
                    .userName { config in
                        HStack {
                            Text(config.nickname)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 4)
                                .foregroundStyle(customFlag ? .green : .red)
                                .background(
                                    RoundedRectangle(cornerRadius: 14)
                                        .fill(Color.indigo)
                                )
                        }
                    }
                }
            )
            CustomButton()
        }
    }
}

#Preview {
    CustomCreateGroupChannel.ViewConverter.List.userNameLabel()
}
