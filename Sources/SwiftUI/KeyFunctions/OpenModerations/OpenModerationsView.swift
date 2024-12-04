//
//  OpenModerationsView.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SwiftUI
import SendbirdChatSDK

/// A view that displays a OpenModerations
public struct OpenModerationsView: View {
    // MARK: - Properties
    @Environment(\.dismiss)
    private var dismiss
    
    var configurations: [(SBUModerationsViewController) -> Void] = []

    // Non-optional since `channelURL` is required.
    @ObservedObject private var provider: OpenModerationsViewProvider
    
    init(provider: OpenModerationsViewProvider) {
        self.provider = provider
    }
    
    public var body: some View {
        SBUViewControllerSet.OpenModerationsViewController
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
                SBViewConverterSet.OpenModerations = OpenModerationsViewConverter()
            }
    }
    
    // MARK: - Methods
    private func createViewController() -> SBUModerationsViewController {
        let viewController = SBUViewControllerSet.OpenModerationsViewController.init(
            channelURL: self.provider.channelURL,
            channelType: .open
        )
        
        // hook up VC, VM into provider
        self.provider.bind(viewController: viewController)
        
        return viewController
    }
    
    private func shouldUpdateData(viewController: SBUModerationsViewController) -> Bool {
        let shouldUpdateChannelURL = viewController.viewModel?.channelURL == "" && self.provider.channelURL != ""
        return shouldUpdateChannelURL
    }
}

// MARK: - Initializers
/// OpenModerationsView initializers
public extension OpenModerationsView {
    // MARK: - typealias
    // typealias ListContent = OpenModerationsViewConverter.List
    
    init(
        provider: OpenModerationsViewProvider,
        headerItem: (() -> OpenModerationsType.HeaderItem)? = nil
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
        OpenModerationsView(provider: .init(channelURL: ""))
    }
}
