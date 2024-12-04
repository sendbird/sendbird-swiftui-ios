//
//  CustomGroupChannelList.SwiftUI.View.ViewProvider.swift
//
//  Created by Celine Moon on 11/14/24.
//

import SwiftUI
#if canImport(SendbirdSwiftUI)
import SendbirdSwiftUI
#endif

extension CustomGroupChannelList.SwiftUI.View {
    struct ViewProvider: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        @StateObject var provider = GroupChannelListViewProvider()

        var body: some View {
            VStack {
                GroupChannelListView(provider: provider)
                    // Demo of event methods.
                    .onSendbirdSelectRow { indexPath in
                        print("Tapped on \(indexPath.row)!")
                        // do actions here.
                    }

                VStack {
                    // Demo of @Published properties.
                    Text("Last message of latest channel: \(provider.channels.first?.lastMessage?.message ?? "nil")")
                        .padding()
                        .background(Color.pink.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .font(.system(size: 13))
                    Text("Channel list is \(provider.isLoading ? "Loading..." : "Loaded!")")
                        .padding()
                        .background(Color.pink.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .font(.system(size: 13))

                    // Demo of function call.
                    Button {
                        provider.showCreateChannel()
                    } label: {
                        Text("Create Channel Button")
                            .padding()
                            .background(Color.blue.opacity(0.7))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .font(.system(size: 13))
                    }
                }
                .onAppear()
            }
        }

    }
}
