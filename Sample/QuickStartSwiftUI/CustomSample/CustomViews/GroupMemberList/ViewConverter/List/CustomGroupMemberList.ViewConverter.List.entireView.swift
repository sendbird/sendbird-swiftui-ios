import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomGroupMemberList.ViewConverter.List {
    struct entireView: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        @StateObject var provider: GroupMemberListViewProvider
        @State var customFlag: Bool = false

        // case 1: view init timing
        var body: some View {
            VStack {
                if let channelURL = viewModel.groupChannel?.channelURL {
                    GroupMemberListView(
                        provider: provider.setup(channelURL: channelURL, customUsers: nil)
                    )
                    CustomButton()
                }
            }
        }
        
        // case 2: onAppear timing
        var body1: some View {
            VStack {
                GroupMemberListView(
                    provider: provider
                )
                .onAppear {
                    if let channelURL = viewModel.groupChannel?.channelURL {
                        provider.setup(channelURL: channelURL, customUsers: nil)
                    }
                }
                CustomButton()
            }
        }
        
        // MARK: - Minor views
        func CustomButton() -> Button<some View> {
            return Button {
                customFlag.toggle()
            } label: {
                Text("Toggle")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
            }
        }
        
        fileprivate func MemberList(
            viewConfig: GroupMemberListViewConverter.List.TableView.ViewConfig
        ) -> List<Never, ForEach<[SBUUser], String, some View>> {
            return List(provider.members, id: \.userId) { user in
                HStack {
                    Circle()
                        .frame(width: 12, height: 12)
                        .foregroundStyle(user.isOperator ? .green : .red)
                    Text("\(user.refinedNickname())")
                }
                .onAppear {
                    if user.userId == provider.members.last?.userId {
                        provider.loadNextMemberList()
                    }
                }
            }
        }
    }
}

#Preview {
    CustomGroupMemberList.ViewConverter.List.entireView(provider: .init(channelURL: ""))
}
