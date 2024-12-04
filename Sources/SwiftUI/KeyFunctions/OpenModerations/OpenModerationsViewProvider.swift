//
//  OpenModerationsViewProvider.swift
//  SendbirdUIKit
//
//  Created by Tez Park on 10/22/24.
//

import Foundation
import SwiftUI
import SendbirdChatSDK
 
// swiftlint:disable type_name
// MARK: ViewEventHandlers
public struct OpenModerationsViewEventHandlers {
    // Blocks for handling for user inputs.
    var didChangeFrozenStateHandler: ((_ isFrozen: Bool) -> Void)?
    
    // Blocks for handling for internal events.
    var errorHandler: ((_ error: SBError?) -> Void)?
}
// swiftlint:enable type_name

// MARK: - OpenModerationsViewProvider
public class OpenModerationsViewProvider: SendbirdUIProvider {
    // Init properties
    var channelURL: String
    
    // SendbirdProvider protocol
    weak var viewController: SBUModerationsViewController?
    var eventHandlers = OpenModerationsViewEventHandlers()
    
    // MARK: Public Data Properties
    // Note: @Published properties can't be computed properties.
    @Published public var participants: [SBUUser] = []
    @Published public var selectedParticipants: [SBUUser] = []
    @Published public var isLoading: Bool = false
    
    // MARK: Public Data Properties
    public var channel: OpenChannel?
    
    // MARK: Public UI Properties

    // MARK: Methods
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
    public func changeFreeze(_ freeze: Bool) {
        self.viewController?.changeFreeze(freeze)
    }
    
    // MARK: ViewModel method wrappers
    // nothing
}

extension OpenModerationsViewProvider: SBUModerationsViewModelDelegate {
    public func moderationsViewModel(
        _ viewModel: SBUModerationsViewModel,
        didChangeChannel channel: SendbirdChatSDK.BaseChannel?,
        withContext context: SendbirdChatSDK.MessageContext
    ) {
        //
    }
}
    
extension OpenModerationsViewProvider: SBUCommonViewModelDelegate {
    public func shouldUpdateLoadingState(_ isLoading: Bool) {
        StateImpactHandler.safeExecute { [weak self] in
            self?.isLoading = isLoading
        }
    }
    
    public func didReceiveError(_ error: SendbirdChatSDK.SBError?, isBlocker: Bool) {
        self.eventHandlers.errorHandler?(error)
    }
}

extension OpenModerationsViewProvider: ModerationsViewEventDelegate {
    func moderationsView(didChangeFrozenState isFrozen: Bool) {
        self.eventHandlers.didChangeFrozenStateHandler?(isFrozen)
    }
}

