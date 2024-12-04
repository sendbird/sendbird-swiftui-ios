import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomOpenParticipantList.ViewConverter.Header {
    struct leftView: View {
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
                provider: OpenParticipantListViewProvider(channelURL: TestURL.openChannel),
                headerItem: {
                    .init()
                    .leftView { config in
                        Text("Left \(customFlag ? "ON" : "OFF")")
                            .foregroundStyle(.blue)
                    }
                }
            )
            CustomButton()
        }
    }
}

#Preview {
    CustomOpenParticipantList.ViewConverter.Header.leftView()
}
