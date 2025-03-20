//
//  GroupChannelSettingsView.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SwiftUI
import SendbirdChatSDK

/// A view that displays a GroupChannelSettings
public struct GroupChannelSettingsView: View {
    // MARK: - Properties
    @Environment(\.dismiss)
    private var dismiss
    
    var configurations: [(SBUGroupChannelSettingsViewController) -> Void] = []

    @ObservedObject var provider: GroupChannelSettingsViewProvider
    
    init(provider: GroupChannelSettingsViewProvider) {
        self.provider = provider  // Default
    }
    
    public var body: some View {
        SBUViewControllerSet.GroupChannelSettingsViewController
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
                    SBViewConverterSet.GroupChannelSettings = GroupChannelSettingsViewConverter()
                }
            }
    }
    
    // MARK: - Methods
    private func createViewController() -> SBUGroupChannelSettingsViewController {
        let viewController = SBUViewControllerSet.GroupChannelSettingsViewController.init(channelURL: self.provider.channelURL)
        self.provider.bind(viewController: viewController)
        return viewController
    }
    
    private func shouldUpdateData(viewController: SBUGroupChannelSettingsViewController) -> Bool {
        let shouldUpdateChannelURL = viewController.viewModel?.channelURL == "" && self.provider.channelURL != ""
        return shouldUpdateChannelURL
    }
}

// MARK: - Initializers
/// GroupChannelSettingsView initializers
public extension GroupChannelSettingsView {
    // MARK: - typealias
    typealias ListContent = GroupChannelSettingsViewConverter.List
    
    init(
        provider: GroupChannelSettingsViewProvider,
        headerItem: (() -> GroupChannelSettingsType.HeaderItem)? = nil,
        listItem: (() -> GroupChannelSettingsType.ListItem)? = nil
    ) {
        self.provider = provider
        
        if let headerItem { _ = headerItem() }
        if let listItem { _ = listItem() }
        
        // Apply view converter in viewConverterSet.
        self.applyViewConverterSet()
    }
    
    // TODO: After entire content is implemented
    internal init<Content: View>(
        provider: GroupChannelSettingsViewProvider,
        headerItem: (() -> GroupChannelSettingsType.HeaderItem)? = nil,
        list: @escaping (ListContent.TableView.ViewConfig) -> Content
    ) {
        self.init(provider: provider, headerItem: headerItem, listItem: nil)
        
        typealias ViewConverterType = ViewConverter<ListContent.TableView.ViewConfig>
        let listViewConverter: ViewConverterType = ViewConverter { listConfig in
            UIHostingController(rootView: list(listConfig)).view
        }
        
        self.viewConverter.list.tableView.entireContent = listViewConverter
        self.viewConverter.list.tableView.viewUpdateHandlers[.entireContent] = { vc in
            vc.listComponent?.reloadTableView()
        }
        
        // Apply view converter in viewConverterSet.
        self.applyViewConverterSet()
    }
}

#Preview {
    NavigationView {
        GroupChannelSettingsView(
            provider: .init(
                channelURL: DefaultViewConfigSet.groupChannel.channelURL
            )
        )
    }
}
