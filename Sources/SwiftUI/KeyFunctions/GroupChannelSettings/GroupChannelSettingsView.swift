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
    
    private var channelURL: String
    
    // MARK: - Methods
    public var body: some View {
        SBUViewControllerSet.GroupChannelSettingsViewController
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
    
    private func createViewController() -> SBUGroupChannelSettingsViewController {
        SBUViewControllerSet.GroupChannelSettingsViewController.init(channelURL: channelURL)
    }
}

// MARK: - Initializers
/// GroupChannelSettingsView initializers
public extension GroupChannelSettingsView {
    // MARK: - typealias
    typealias ListContent = GroupChannelSettingsViewConverter.List
    
    init(
        channelURL: String,
        headerItem: (() -> GroupChannelSettingsType.HeaderItem)? = nil,
        listItem: (() -> GroupChannelSettingsType.ListItem)? = nil
    ) {
        self.channelURL = channelURL
        
        if let headerItem { _ = headerItem() }
        if let listItem { _ = listItem() }
        
        // Apply view converter in viewConverterSet.
        self.applyViewConverterSet()
    }
    
    init<Content: View>(
        channelURL: String,
        headerItem: (() -> GroupChannelSettingsType.HeaderItem)? = nil,
        list: @escaping (ListContent.TableView.ViewConfig) -> Content
    ) {
        self.init(channelURL: channelURL, headerItem: headerItem, listItem: nil)
        
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
        GroupChannelSettingsView(channelURL: DefaultViewConfigSet.groupChannel.channelURL)
    }
}
