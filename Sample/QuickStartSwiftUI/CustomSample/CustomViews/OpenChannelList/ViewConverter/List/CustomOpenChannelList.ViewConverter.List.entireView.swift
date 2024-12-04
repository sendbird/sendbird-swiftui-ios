import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomOpenChannelList.ViewConverter.List {
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
            OpenChannelListView()
            
            CustomButton()
        }
    }
}

#Preview {
    CustomOpenChannelList.ViewConverter.List.entireView()
}
