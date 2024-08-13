import SwiftUI

extension CustomGroupChannel.ViewConverter.List {
    struct channelStateBanner: View {
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
                        .channelStateBanner { config in
                            HStack {
                                Spacer()
                                Text("Channel state goes here")
                                Spacer()
                            }
                            .background(customFlag ? Color.yellow : Color.indigo)
                        }
                    }
                )
                CustomButton()
            }
        }
    }
}

#Preview {
    CustomGroupChannel.ViewConverter.List.channelStateBanner()
}
