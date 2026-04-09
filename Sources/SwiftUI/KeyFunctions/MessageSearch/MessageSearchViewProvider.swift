//
//  MessageSearchViewProvider.swift
//  SendbirdUIKit
//
//  Created by Celine Moon on 10/22/24.
//

import Foundation
import SwiftUI
import SendbirdChatSDK

/// Event handlers for the Message Search view.
public struct MessageSearchEventHandlers {

}

/// A provider that manages data and state for the Message Search view.
public class MessageSearchViewProvider: SendbirdUIProvider {
    // init params
    var channelURL: String
    var messageSearchQueryParams: MessageSearchQueryParams?
    
    // SendbirdUIProvider protocol
    weak var viewController: SBUMessageSearchViewController?
    var eventHandlers = MessageSearchEventHandlers()
    
    /// Initializes a new provider with the given parameters.
    public init(
        channelURL: String,
        messageSearchQueryParams: MessageSearchQueryParams? = nil
    ) {
        self.channelURL = channelURL
        self.messageSearchQueryParams = messageSearchQueryParams
    }

    /// This function sets up the provider.
    @discardableResult
    public func setup(
        channelURL: String,
        messageSearchQueryParams: MessageSearchQueryParams? = nil
    ) -> Self {
        self.channelURL = channelURL
        if let messageSearchQueryParams { self.messageSearchQueryParams = messageSearchQueryParams }
        return self
    }
    
    func bind(viewController: SBUMessageSearchViewController) {
        viewController.swiftUIDelegate = self
        self.viewController = viewController
    }
}

extension MessageSearchViewProvider: SBUMessageSearchViewModelDelegate {
    public func searchViewModel(_ viewModel: SBUMessageSearchViewModel, didChangeSearchResults results: [SendbirdChatSDK.BaseMessage], needsToReload: Bool) {
        
    }
    
    public func shouldUpdateLoadingState(_ isLoading: Bool) {
        
    }
    
    public func didReceiveError(_ error: SendbirdChatSDK.SBError?, isBlocker: Bool) {
        
    }
}

extension MessageSearchViewProvider: MessageSearchViewEventDelegate {
    
}
