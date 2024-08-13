import SwiftUI

extension CustomOpenOperatorList.ViewConverter.List {
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
            OpenOperatorListView(
                channelURL: TestURL.openChannel,
                listItem: {
                    .init()
                    .rowView { config in
                        HStack {
                            Circle()
                                .frame(width: 12, height: 12)
                                .foregroundStyle(.red)
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
    CustomOpenOperatorList.ViewConverter.List.rowView()
}
