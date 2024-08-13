import SwiftUI

extension CustomOpenOperatorList.ViewConverter.List {
    struct profileImage: View {
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
            OpenOperatorListView(
                channelURL: TestURL.openChannel,
                listItem: {
                    .init()
                    .profileImage { config in
                        let overlayColor = self.customFlag ? Color.white : Color.cyan
                        AsyncImage(url: URL(string: config.profileURL)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: config.imageSize.width, height: config.imageSize.height)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(overlayColor, lineWidth: 4))
                                .shadow(radius: 10)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
            )
            CustomButton()
        }
    }
}
 
#Preview {
    CustomOpenOperatorList.ViewConverter.List.profileImage()
}
