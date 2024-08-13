import SwiftUI

extension CustomOpenParticipantList.ViewConverter.List {
    struct operatorStateView: View {
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
            OpenParticipantListView(
                channelURL: TestURL.openChannel,
                listItem: {
                    .init()
                    .operatorStateView { config in
                        HStack {
                            Text(config.isOperator ? "Operator" : "")
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
    CustomOpenParticipantList.ViewConverter.List.operatorStateView()
}
