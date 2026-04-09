//
//  CreateOpenChannelViewProvider.swift
//  SendbirdUIKit
//
//  Created by Celine Moon on 10/22/24.
//

import Foundation
import SwiftUI
import SendbirdChatSDK

// MARK: - ViewEventHandlers
/// Event handlers for the Create Open Channel view.
public struct CreateOpenChannelEventHandlers {
    // Blocks for handling for internal events.
    var errorHandler: ((_ error: SBError?) -> Void)?
}

// MARK: - CreateOpenChannelViewProvider
/// A provider that manages data and state for the Create Open Channel view.
public class CreateOpenChannelViewProvider: SendbirdUIProvider {
    // init properties
    
    // SendbirdUIProvider properties
    weak var viewController: SBUCreateOpenChannelViewController?
    var eventHandlers = CreateOpenChannelEventHandlers()
    
    // MARK: Public Data Properties
    /// Indicates whether the view is currently loading.
    @Published public var isLoading: Bool = false

    // MARK: Public UI Properties

    // MARK: Methods
    /// Initializes a new provider with default parameters.
    public init() {}
    
    /// This function sets up the provider.
    @discardableResult
    internal func setup() -> Self {
        return self
    }
    
    func bind(viewController: SBUCreateOpenChannelViewController) {
        viewController.swiftUIDelegate = self
        self.viewController = viewController
    }
    
    // MARK: UIKit method wrappers
    /// Creates a new open channel with the given parameters.
    public func createChannel(params: OpenChannelCreateParams) {
        self.viewController?.viewModel?.createChannel(params: params)
    }
}

// MARK: - ViewEventDelegate
extension CreateOpenChannelViewProvider: CreateOpenChannelViewEventDelegate {
}

// MARK: - ViewModelDelegate
extension CreateOpenChannelViewProvider: SBUCreateOpenChannelViewModelDelegate {
}

extension CreateOpenChannelViewProvider: SBUCommonViewModelDelegate {
    public func shouldUpdateLoadingState(_ isLoading: Bool) {
        StateImpactHandler.safeExecute { [weak self] in
            self?.isLoading = isLoading
        }
    }
    
    public func didReceiveError(_ error: SendbirdChatSDK.SBError?, isBlocker: Bool) {
        self.eventHandlers.errorHandler?(error)
    }
}

// MARK: - ViewModelDelegate (default implementation)
extension SBUCreateOpenChannelViewModelDelegate {
    /// Called when the create open channel view model has created a channel.
    public func createOpenChannelViewModel(_ viewModel: SBUCreateOpenChannelViewModel, didCreateChannel channel: SendbirdChatSDK.BaseChannel?) { }
}
