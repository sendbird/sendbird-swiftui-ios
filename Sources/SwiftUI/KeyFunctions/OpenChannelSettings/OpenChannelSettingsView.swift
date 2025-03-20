//
//  OpenChannelSettingsView.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SwiftUI
import SendbirdChatSDK

/// A view that displays a OpenChannelSettings
public struct OpenChannelSettingsView: View {
    // MARK: - Properties
    @Environment(\.dismiss)
    private var dismiss
    
    var configurations: [(SBUOpenChannelSettingsViewController) -> Void] = []
    
    @ObservedObject var provider: OpenChannelSettingsViewProvider
    
    init(provider: OpenChannelSettingsViewProvider) {
        self.provider = provider
    }
        
    // MARK: - Methods
    public var body: some View {
        SBUViewControllerSet.OpenChannelSettingsViewController
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
                if GlobalOptions.enableViewAdaptorAutoReset {
                    SBViewConverterSet.OpenChannelSettings = OpenChannelSettingsViewConverter()
                }
            }
    }
    
    // MARK: - Methods
    private func createViewController() -> SBUOpenChannelSettingsViewController {
        let viewController = SBUViewControllerSet.OpenChannelSettingsViewController.init(
            channelURL: self.provider.channelURL
        )
        provider.bind(viewController: viewController)
        return viewController
    }
    
    private func shouldUpdateData(viewController: SBUOpenChannelSettingsViewController) -> Bool {
        let shouldUpdateChannelURL = viewController.viewModel?.channelURL == "" && self.provider.channelURL != ""
        return shouldUpdateChannelURL
    }
}

// MARK: - Initializers
/// OpenChannelSettingsView initializers
public extension OpenChannelSettingsView {
    // MARK: - typealias
    // TODO: Initializer 에서 필요하면 구현
    // typealias ListContent = OpenChannelSettingsViewConverter.List
    
// (↓↓ example ↓↓)
    init(
        provider: OpenChannelSettingsViewProvider,
        headerItem: (() -> OpenChannelSettingsType.HeaderItem)? = nil
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
        OpenChannelSettingsView(provider: .init(channelURL: ""))
    }
}
