import SwiftUI

extension CustomOpenParticipantList.ViewConverter.List {
    struct rowView: View {
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
                    .rowView { config in
                        HStack {
                            Circle()
                                .frame(width: 12, height: 12)
                                .foregroundStyle(config.isOperator ? .green : .red)
                            Text("\(config.user.refinedNickname()) - \(self.customFlag ? "ON" : "OFF")")
                                .foregroundStyle(.black)
                        }
                    }
                }
            )
            CustomButton()
        }
    }
}

#Preview {
    CustomOpenParticipantList.ViewConverter.List.rowView()
}
