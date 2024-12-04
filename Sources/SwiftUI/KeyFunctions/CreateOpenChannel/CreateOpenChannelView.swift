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
    
    @ObservedObject private var provider: CreateOpenChannelViewProvider
    
    public init() {
        self.provider = CreateOpenChannelViewProvider()  // Default provider
    }
    
    public var body: some View {
        SBUViewControllerSet.CreateOpenChannelViewController
            .swiftUI {
                createViewController()
            }
            .injectData { viewController in
                if self.shouldUpdateData(viewController: viewController) {
                    // Inject data into view model and load
                    //  Nothing to load
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
                SBViewConverterSet.CreateOpenChannel = CreateOpenChannelViewConverter()
            }
    }
    
    // MARK: - Methods
    private func createViewController() -> SBUCreateOpenChannelViewController {
        let viewController = SBUViewControllerSet.CreateOpenChannelViewController.init()
        // Connect provider <-> VC, VM
        self.provider.bind(viewController: viewController)
        return viewController
    }
    
    private func shouldUpdateData(viewController: SBUCreateOpenChannelViewController) -> Bool {
        return true
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
        provider: CreateOpenChannelViewProvider? = nil,
        headerItem: (() -> CreateOpenChannelType.HeaderItem)? = nil
    ) {
        self.provider = provider ?? CreateOpenChannelViewProvider()  // Default provider
        
        if let headerItem { _ = headerItem() }
        // TODO: SwiftUI - header 외 요소 추가 필요

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

// MARK: Event handler interfaces
public extension CreateOpenChannelView {
    func onSendbirdError(_ errorHandler: @escaping ((_ error: SBError?) -> Void)) -> Self {
        let copy = self
        copy.provider.eventHandlers.errorHandler = errorHandler
        return copy
    }
}


#Preview {
    NavigationView {
        CreateOpenChannelView()
    }
}
