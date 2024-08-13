import SwiftUI
extension CustomMessageSearch.SwiftUI.View {
    struct CustomMain: View {
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
            
// Currently only header is tested
//            if let channelURL = viewModel.groupChannel?.channelURL {
//            MessageSearchView(
//                channelURL: channelURL,
//                headerItem: {
//                    .init()
//                    .leftView { config in
//                        Button {
//                            print("left button tapped")
//                            config.parentView.cancelSearch()
//                            // TODO: SwiftUI - 구현 필요할지 체크 필요 (원래 없는 액션)
//                        } label: {
//                            Text("Left \(customFlag ? "ON" : "OFF")")
//                        }
//                    }
//                    .rightView { config in
//                        Button {
//                            print("right button tapped")
//                            config.parentView.cancelSearch()
//                        // TODO: SwiftUI - 구현 필요할지 체크 필요 (원래 없는 액션)
//                        } label: {
//                            Text("Right \(customFlag ? "ON" : "OFF")")
//                        }
//                    }
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
//
//            CustomButton()
//        }
        }
    }
}

#Preview {
    CustomMessageSearch.SwiftUI.View.CustomMain()
}
