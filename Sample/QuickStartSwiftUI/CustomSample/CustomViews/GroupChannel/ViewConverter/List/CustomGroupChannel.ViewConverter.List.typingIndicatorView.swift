import SwiftUI

extension CustomGroupChannel.ViewConverter.List {
    struct typingIndicatorView: View {
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
                        .typingIndicatorView { config in
                            HStack {
                                Text("\(config.typingInfo.numberOfTypers) members are typing")
                                
                                Circle().frame(width: 6, height: 6).foregroundStyle(customFlag ? .green : .red)
                                Circle().frame(width: 6, height: 6).foregroundStyle(customFlag ? .green : .red)
                                Circle().frame(width: 6, height: 6).foregroundStyle(customFlag ? .green : .red)
                            }
                            .padding()
                            .background(Color.indigo)
                        }
                    }
                )
                CustomButton()
            }
        }
    }
}

#Preview {
    CustomGroupChannel.ViewConverter.List.typingIndicatorView()
}

// TODO: Sample 용 mock setting
