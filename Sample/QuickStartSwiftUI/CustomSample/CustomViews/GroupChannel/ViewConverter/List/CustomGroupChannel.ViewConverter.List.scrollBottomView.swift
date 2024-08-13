import SwiftUI

extension CustomGroupChannel.ViewConverter.List {
    struct scrollBottomView: View {
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
                        .scrollBottomView { viewConfig in
                            Image(systemName: "arrowshape.down.circle.fill")
                                .resizable()
                                .frame(width: viewConfig.buttonSize.width, height: viewConfig.buttonSize.height)
                                .aspectRatio(contentMode: .fill)
                                .foregroundStyle(customFlag ? Color.cyan : Color.green)
                                .background(Color.indigo)
                                .clipShape(Circle())
                                .shadow(radius: 10)
                        }
                    }
                )
                CustomButton()
            }
        }
    }
}

#Preview {
    CustomGroupChannel.ViewConverter.List.scrollBottomView()
}
