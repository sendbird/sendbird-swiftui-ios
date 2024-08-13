import SwiftUI

extension CustomMessageSearch.ViewConverter.Header {
    struct leftView: View {
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
//                    .leftView { config in
//                        Button {
//                            print("left button tapped")
//                            config.parentView.cancelSearch()
////                            config.parentView.onTapLeftBarButton()
//                            // TODO: SwiftUI - 구현 필요할지 체크 필요 (원래 없는 액션)
//                        } label: {
//                            Text("Left \(customFlag ? "ON" : "OFF")")
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
    CustomMessageSearch.ViewConverter.Header.leftView()
}
