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
    
    @ObservedObject var provider: GroupChannelPushSettingsViewProvider
    
    public init(provider: GroupChannelPushSettingsViewProvider) {
        self.provider = provider  // Default provider
    }
    
    public var body: some View {
        SBUViewControllerSet.GroupChannelPushSettingsViewController
            .swiftUI {
                createViewController()
            }
            .injectData { viewController in
                if self.shouldUpdateData(viewController: viewController) {
                    // Inject data into view model and load
                    viewController.viewModel?.initializeAndLoad(
                        channelURL: self.provider.channelURL
                    )
                }
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
            .onDisappear {
                SBViewConverterSet.GroupChannelPushSettings = GroupChannelPushSettingsViewConverter()
            }
    }
    
    // MARK: - Methods
    private func createViewController() -> SBUGroupChannelPushSettingsViewController {
        let viewController = SBUViewControllerSet.GroupChannelPushSettingsViewController.init(
            channelURL: self.provider.channelURL
        )
        self.provider.bind(viewController: viewController)
        return viewController
    }
    
    private func shouldUpdateData(viewController: SBUGroupChannelPushSettingsViewController) -> Bool {
        let shouldUpdateChannelURL = viewController.viewModel?.channelURL == "" && self.provider.channelURL != ""
        return shouldUpdateChannelURL
    }
}

// MARK: - Initializers
/// GroupChannelPushSettingsView initializers
public extension GroupChannelPushSettingsView {
    // MARK: - typealias
    // TODO: Initializer 에서 필요하면 구현
    // typealias ListContent = GroupChannelPushSettingsViewConverter.List

// (↓↓ example ↓↓)
    init(
        provider: GroupChannelPushSettingsViewProvider,
        headerItem: (() -> GroupChannelPushSettingsType.HeaderItem)? = nil
    ) {
        self.provider = provider

        if let headerItem { _ = headerItem() }
//        if let listItem { _ = listItem() }

        // Apply view converter in viewConverterSet.
        self.applyViewConverterSet()
    }

    // TODO: After entire content is implemented
//    internal init<Content: View>(
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
        GroupChannelPushSettingsView(provider: .init(channelURL: ""))
    }
}
