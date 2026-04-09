//
//  GroupModerationsViewProvider.swift
//  SendbirdUIKit
//
//  Created by Tez Park on 10/22/24.
//

import Foundation
import SwiftUI
import SendbirdChatSDK
 
// MARK: ViewEventHandlers
/// Event handlers for the Group Moderations view.
public struct GroupModerationsViewEventHandlers {
    // Blocks for handling for user inputs.
    var didChangeFrozenStateHandler: ((_ isFrozen: Bool) -> Void)?

    // Blocks for handling for internal events.
    var errorHandler: ((_ error: SBError?) -> Void)?
}

// MARK: - GroupModerationsViewProvider
/// A provider that manages data and state for the Group Moderations view.
public class GroupModerationsViewProvider: SendbirdUIProvider {
    // Init properties
    var channelURL: String
    
    // SendbirdProvider protocol
    weak var viewController: SBUModerationsViewController?
    var eventHandlers = GroupModerationsViewEventHandlers()
    
    // MARK: Public Data Properties
    // Note: @Published properties can't be computed properties.
    /// The list of participants in the channel.
    @Published public var participants: [SBUUser] = []
    /// The list of currently selected participants.
    @Published public var selectedParticipants: [SBUUser] = []
    /// Indicates whether the view is currently loading.
    @Published public var isLoading: Bool = false

    // MARK: Public Data Properties
    /// The current open channel object.
    public var channel: OpenChannel?
    
    // MARK: Public UI Properties

    // MARK: Methods
    /// Initializes a new provider with the given channel URL.
    public init(channelURL: String) {
        self.channelURL = channelURL
    }

    /// This function sets up the provider.
    @discardableResult
    public func setup(
        channelURL: String
    ) -> Self {
        self.channelURL = channelURL
        return self
    }

    func bind(viewController: SBUModerationsViewController) {
        viewController.swiftUIDelegate = self
        self.viewController = viewController
    }

    // MARK: ViewController method wrappers
    /// Freezes or unfreezes the channel.
    public func changeFreeze(_ freeze: Bool) {
        self.viewController?.changeFreeze(freeze)
    }
    
    // MARK: ViewModel method wrappers
    // nothing
}

extension GroupModerationsViewProvider: SBUModerationsViewModelDelegate {
    public func moderationsViewModel(
        _ viewModel: SBUModerationsViewModel,
        didChangeChannel channel: SendbirdChatSDK.BaseChannel?,
        withContext context: SendbirdChatSDK.MessageContext
    ) {
        // 
    }
}
    
extension GroupModerationsViewProvider: SBUCommonViewModelDelegate {
    public func shouldUpdateLoadingState(_ isLoading: Bool) {
        StateImpactHandler.safeExecute { [weak self] in
            self?.isLoading = isLoading
        }
    }
    
    public func didReceiveError(_ error: SendbirdChatSDK.SBError?, isBlocker: Bool) {
        self.eventHandlers.errorHandler?(error)
    }
}

extension GroupModerationsViewProvider: ModerationsViewEventDelegate {
    func moderationsView(didChangeFrozenState isFrozen: Bool) {
        self.eventHandlers.didChangeFrozenStateHandler?(isFrozen)
    }
}
