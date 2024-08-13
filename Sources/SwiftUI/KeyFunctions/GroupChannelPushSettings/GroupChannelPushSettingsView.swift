//
//  GroupChannelPushSettingsView.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SwiftUI
import SendbirdChatSDK

/// A view that displays a GroupChannelPushSettings
public struct GroupChannelPushSettingsView: View {
    // MARK: - Properties
    @Environment(\.dismiss)
    private var dismiss
    
    var configurations: [(SBUGroupChannelPushSettingsViewController) -> Void] = []
    
    private var channelURL: String
    
    // MARK: - Methods
    public var body: some View {
        SBUViewControllerSet.GroupChannelPushSettingsViewController
            .swiftUI {
                createViewController()
            }
            .configure { viewController in
                viewController.dismissAction = {
                    dismiss()
                }
                
                // Used in SubViewBuilder
                configurations.forEach { config in
                    config(viewController)
                }
                
                // Apply viewUpdateHandlers recursively
                viewConverter.applyViewUpdates(to: viewController)
            }
            .switchUIKitNavigationBar()
    }
    
    private func createViewController() -> SBUGroupChannelPushSettingsViewController {
        let viewController = SBUViewControllerSet.GroupChannelPushSettingsViewController.init(
            channelURL: channelURL
        )
        return viewController
    }
}

// MARK: - Initializers
/// GroupChannelPushSettingsView initializers
public extension GroupChannelPushSettingsView {
    // MARK: - typealias
    // TODO: Initializer 에서 필요하면 구현
    // typealias ListContent = GroupChannelPushSettingsViewConverter.List

    init(channelURL: String) {
        self.channelURL = channelURL
    }
    
// (↓↓ example ↓↓)
    init(
        channelURL: String,
        headerItem: (() -> GroupChannelPushSettingsType.HeaderItem)? = nil
    ) {
        self.channelURL = channelURL

        if let headerItem { _ = headerItem() }
//        if let listItem { _ = listItem() }

        // Apply view converter in viewConverterSet.
        self.applyViewConverterSet()
    }
//
//    init<Content: View>(
//        channelListQuery: GroupChannelListQuery? = nil,
//        headerItem: (() -> Sendbird.View.GroupChannel.ChannelList.HeaderItem)? = nil,
//        list: @escaping (ListContent.ViewConfig) -> Content
//    ) {
//        self.init(channelListQuery: channelListQuery, headerItem: headerItem, listItem: nil)
//
//        typealias ViewConverterType = ViewConverter<ListContent.ViewConfig>
//        let listViewConverter: ViewConverterType = ViewConverter { listConfig in
//            UIHostingController(rootView: list(listConfig)).view
//        }
//
//        self.viewConverter.list.entireContent = listViewConverter
//        self.viewConverter.list.viewUpdateHandlers[.entireContent] = { vc in
//            vc.listComponent?.reloadTableView()
//        }
//
//        // Apply view converter in viewConverterSet.
//        self.applyViewConverterSet()
//    }
}

#Preview {
    NavigationView {
        GroupChannelPushSettingsView(channelURL: "")
    }
}
