import SwiftUI

extension CustomOpenChannel.ViewConverter.List {
    struct adminMessageView: View {
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
            if let channelURL = viewModel.openChannel?.channelURL {
                VStack {
                    OpenChannelView(
                        channelURL: channelURL,
                        listItem: {
                            .init()
                            .adminMessageView { config in
                                Text(config.message.message)
                                    .foregroundStyle(customFlag ? .green : .red)
                                    .padding()
                                    .background(Color.yellow)
                            }
                            //                        .adminMessageView { config in
                            //                            let overlayColor = self.customFlag ? Color.indigo : Color.cyan
                            //                            Text(config.message.message)
                            //                                .frame(maxWidth: .infinity)
                            //                                .padding(.horizontal, 15)
                            //                                .background(overlayColor)
                            //                        }
                        }
                    )
                    CustomButton()
                }
                .onDisappear {
                    reset()
                }
            }
        }
        
        init() {
            SBUViewControllerSet.OpenChannelViewController = CustomOpenChannelVC.self
        }
    }
}

#Preview {
    CustomOpenChannel.ViewConverter.List.adminMessageView()
}

extension CustomOpenChannel.ViewConverter.List.adminMessageView {
    func reset() {
        SBUViewControllerSet.OpenChannelViewController = SBUOpenChannelViewController.self
    }
}

// This is custom code to process a admin message list for a sample.
import SendbirdChatSDK
class CustomOpenChannelVC: SBUOpenChannelViewController {
    override func baseChannelModule(
        _ listComponent: SBUBaseChannelModule.List,
        fullMessagesInTableView tableView: UITableView
    ) -> [BaseMessage] {
        let adminMsg1 = AdminMessage.make(["message":"Hello, I'm admin message!"])!
        let adminMsg2 = AdminMessage.make(["message":"short admin message"])!
        let adminMsg3 = AdminMessage.make(["message":"Loooooooooooooooooooooooooooooooooooooooon admin message"])!
        return [adminMsg3, adminMsg2, adminMsg1]
    }
}
