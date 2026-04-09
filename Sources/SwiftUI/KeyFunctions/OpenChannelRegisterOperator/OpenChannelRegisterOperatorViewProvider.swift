//
//  OpenChannelRegisterOperatorViewProvider.swift
//  SendbirdUIKit
//
//  Created by Tez Park on 10/22/24.
//

import Foundation
import SwiftUI
import SendbirdChatSDK

// swiftlint:disable type_name
// MARK: ViewEventHandlers
/// Event handlers for the Open Channel Register Operator view.
public struct OpenChannelRegisterOperatorViewEventHandlers {
    // Blocks for handling for user inputs.
    var selectRowHandler: ((_ indexPath: IndexPath) -> Void)?
    var didRegisterOperatorsHandler: ((_ operatorIds: [String]) -> Void)?

    // Blocks for handling for internal events.
    var errorHandler: ((_ error: SBError?) -> Void)?
}
// swiftlint:enable type_name

// MARK: - OpenChannelRegisterOperatorViewProvider
/// A provider that manages data and state for the Open Channel Register Operator view.
public class OpenChannelRegisterOperatorViewProvider: SendbirdUIProvider {
    // Init properties
    var channelURL: String
    var customUsers: [SBUUser]?
    
    // SendbirdProvider protocol
    weak var viewController: SBURegisterOperatorViewController?
    var eventHandlers = OpenChannelRegisterOperatorViewEventHandlers()
    
    // MARK: Public Data Properties
    // Note: @Published properties can't be computed properties.
    /// The list of participants available to register as operators.
    @Published public var participants: [SBUUser] = []
    /// The list of participants currently selected for operator registration.
    @Published public var selectedParticipants: [SBUUser] = []
    /// Indicates whether the view is currently loading.
    @Published public var isLoading: Bool = false

    // MARK: Public Data Properties
    /// The current open channel object.
    public var channel: OpenChannel?
    
    // MARK: Public UI Properties

    // MARK: Methods
    /// Initializes a new provider with the given parameters.
    public init(
        channelURL: String,
        customUsers: [SBUUser]? = nil
    ) {
        self.channelURL = channelURL
        self.customUsers = customUsers
    }

    /// This function sets up the provider.
    @discardableResult
    public func setup(
        channelURL: String,
        customUsers: [SBUUser]? = nil
    ) -> Self {
        self.channelURL = channelURL
        if let customUsers { self.customUsers = customUsers }
        return self
    }

    func bind(viewController: SBURegisterOperatorViewController) {
        viewController.swiftUIDelegate = self
        self.viewController = viewController
    }

    // MARK: ViewController method wrappers
    /// Registers all currently selected participants as operators.
    public func registerOperatorWithSelectedParticipants() {
        self.viewController?.registerSelectedUsers()
    }

    // MARK: ViewModel method wrappers
    /// Registers the specified user IDs as operators in the channel.
    public func registerOperator(with userIds: [String]) {
        self.viewController?.viewModel?.registerAsOperators(userIds: userIds)
    }
}

extension OpenChannelRegisterOperatorViewProvider: SBURegisterOperatorViewModelDelegate {
    public func registerOperatorViewModel(_ viewModel: SBURegisterOperatorViewModel, didRegisterOperatorIds operatorIds: [String]) {
        self.eventHandlers.didRegisterOperatorsHandler?(operatorIds)
    }
    
    public func baseSelectedUserViewModel(_ viewModel: SBUBaseSelectUserViewModel, didChangeUserList users: [SBUUser]?, needsToReload: Bool) {
        guard let users = users else { return }
        StateImpactHandler.safeExecute { [weak self] in
            self?.participants = users
        }
    }
    
    public func baseSelectedUserViewModel(_ viewModel: SBUBaseSelectUserViewModel, didUpdateSelectedUsers selectedUsers: [SBUUser]?) {
        guard let selectedUsers = selectedUsers else { return }
        StateImpactHandler.safeExecute { [weak self] in
            self?.selectedParticipants = selectedUsers
        }
    }
}
    
extension OpenChannelRegisterOperatorViewProvider: SBUCommonViewModelDelegate {
    public func shouldUpdateLoadingState(_ isLoading: Bool) {
        StateImpactHandler.safeExecute { [weak self] in
            self?.isLoading = isLoading
        }
    }
    
    public func didReceiveError(_ error: SendbirdChatSDK.SBError?, isBlocker: Bool) {
        self.eventHandlers.errorHandler?(error)
    }
}

extension OpenChannelRegisterOperatorViewProvider: RegisterOperatorViewEventDelegate {
    func registerOperatorView(didSelectRowAt indexPath: IndexPath) {
        self.eventHandlers.selectRowHandler?(indexPath)
    }
}
