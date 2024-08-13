import SwiftUI

extension CustomGroupChannel.ViewConverter.List {
    struct newMessageInfoView: View {
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
            if let channelURL = viewModel.groupChannel?.channelURL {
                GroupChannelView(
                    channelURL: channelURL,
                    listItem: {
                        .init()
                        .newMessageInfoView { config in
                            HStack {
                                Circle().frame(width: 10, height: 10).foregroundStyle(customFlag ? .green : .red)
                                Text("\(config.count) new messages :)")
                            }
                            .padding()
                            .background(Color.yellow)
                        }
                    }
                )
                CustomButton()
            }
        }
    }
}

#Preview {
    CustomGroupChannel.ViewConverter.List.newMessageInfoView()
}
