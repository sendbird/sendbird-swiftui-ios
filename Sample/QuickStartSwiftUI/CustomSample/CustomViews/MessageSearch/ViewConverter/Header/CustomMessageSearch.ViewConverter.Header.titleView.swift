import SwiftUI

extension CustomMessageSearch.ViewConverter.Header {
    struct titleView: View {
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
            Text("TODO after beta")
//            if let channelURL = viewModel.groupChannel?.channelURL {
//            MessageSearchView(
//                channelURL: channelURL,
//                headerItem: {
//                    .init()
//                    .titleView { config in
//                        Button {
//                            print("header view tapped")
//                            config.parentView.cancelSearch()
//                        } label: {
//                            Text("Header Title \(customFlag ? "ON" : "OFF")")
//                        }
//                    }
//                }
//            )
//            CustomButton()
//            }
        }
    }
}

#Preview {
    CustomMessageSearch.ViewConverter.Header.titleView()
}
