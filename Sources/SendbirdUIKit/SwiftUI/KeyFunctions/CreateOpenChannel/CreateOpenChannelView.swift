//
//  CreateOpenChannelView.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SwiftUI
import SendbirdChatSDK

/// A view that displays a CreateOpenChannel
public struct CreateOpenChannelView: View {
    // MARK: - Properties
    @Environment(\.dismiss)
    private var dismiss
    
    var configurations: [(SBUCreateOpenChannelViewController) -> Void] = []
    
    // MARK: - Methods
    public init() {}
    
    public var body: some View {
        SBUViewControllerSet.CreateOpenChannelViewController
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
    
    private func createViewController() -> SBUCreateOpenChannelViewController {
        let viewController = SBUViewControllerSet.CreateOpenChannelViewController.init(
        )
        return viewController
    }
}

// MARK: - Initializers
/// CreateOpenChannelView initializers
public extension CreateOpenChannelView {
    // MARK: - typealias
    // TODO: Initializer 에서 필요하면 구현
    // typealias ListContent = CreateOpenChannelViewConverter.List
    
// (↓↓ example ↓↓)
    init(
        headerItem: (() -> CreateOpenChannelType.HeaderItem)? = nil
    ) {
        if let headerItem { _ = headerItem() }
        // TODO: SwiftUI - header 외 요소 추가 필요

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
        CreateOpenChannelView()
    }
}
