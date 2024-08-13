//
//  MainView.swift
//  QuickStartSwiftUI
//
//  Created by Celine Moon on 7/11/24.
//

import SwiftUI

struct MainView: View {
    @Environment(\.dismiss) var dismiss
    @State private var activeItem: MainViewItems?
    
    var body: some View {
        List(MainViewItems.allCases) { item in
            NavigationLink(
                destination: item.view,
                tag: item,
                selection: $activeItem,
                label: {
                    Text(item.title)
                }
            )
        }
        .navigationTitle("SwiftUI QA")
        .navigationBarTitleDisplayMode(.large)
        // Receive push notification & move to that channel
        .onReceive(SendbirdUI.PushPayloadManager.pushNotificationPublisher) { channelURL in
            if channelURL.contains("group_channel") {
                activeItem = .group
            }
        }
        
        Button {
            SendbirdUI.disconnect {
                // remove all UserDefaults
                UserDefaults.removeLogInInfo()
                
                // go back to LoginView
                dismiss()
            }
        } label: {
            Text("Log Out")
                .frame(maxWidth: .infinity)
                .roundedBackground(color: .red.opacity(0.9))
                .foregroundStyle(.white)
                .padding()
        }

        Spacer()
            .frame(height: 1)
    }
}

enum MainViewItems: String, CaseIterable, Identifiable {
    case group
    case open
    case mySettings
    case custom
    
    var id: String { self.rawValue }
    var title: String {
        switch self {
        case .group:
            "Group Channels"
        case .open:
            "Open Channels"
        case .mySettings:
            "My Settings"
        case .custom:
            "Customized Samples"
        }
    }
    
    @ViewBuilder var view: some View {
        switch self {
        case .group:
            GroupChannelsView()
        case .open:
            OpenChannelsView()
        case .mySettings:
            MySettingsView()
        case .custom:
            CustomSampleView()
        }
    }
}
