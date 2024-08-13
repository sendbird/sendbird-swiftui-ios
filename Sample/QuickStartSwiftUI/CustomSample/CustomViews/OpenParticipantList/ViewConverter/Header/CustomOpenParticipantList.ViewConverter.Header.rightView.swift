import SwiftUI

extension CustomOpenParticipantList.ViewConverter.Header {
    struct rightView: View {
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
                headerItem: {
                    .init()
                    .rightView { config in
                        Text("Right \(customFlag ? "ON" : "OFF")") // note: there is right view by default
                    }
                }
            )
            
            CustomButton()
        }
    }
}

#Preview {
    CustomOpenParticipantList.ViewConverter.Header.rightView()
}
