//
//  GroupChannelRegisterOperatorViewProvider.swift
//  SendbirdUIKit
//
//  Created by Tez Park on 10/22/24.
//

import Foundation
import SwiftUI
import SendbirdChatSDK

// swiftlint:disable type_name
// MARK: ViewEventHandlers
public struct GroupChannelRegisterOperatorViewEventHandlers {
    // Blocks for handling for user inputs.
    var selectRowHandler: ((_ indexPath: IndexPath) -> Void)?
    var didRegisterOperatorsHandler: ((_ operatorIds: [String]) -> Void)?
    
    // Blocks for handling for internal events.
    var errorHandler: ((_ error: SBError?) -> Void)?
}
// swiftlint:enable type_name

// MARK: - GroupChannelRegisterOperatorViewProvider
public class GroupChannelRegisterOperatorViewProvider: SendbirdUIProvider {
    // Init properties
    var channelURL: String
    var customUsers: [SBUUser]?
    
    // SendbirdProvider protocol
    weak var viewController: SBURegisterOperatorViewController?
    var eventHandlers = GroupChannelRegisterOperatorViewEventHandlers()
    
    // MARK: Public Data Properties
    // Note: @Published properties can't be computed properties.
    @Published public var members: [SBUUser] = []
    @Published public var selectedMembers: [SBUUser] = []
    @Published public var isLoading: Bool = false
    
    // MARK: Public Data Properties
    public var channel: GroupChannel?
    
    // MARK: Public UI Properties

    // MARK: Methods
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
    public func registerOperatorWithSelectedMembers() {
        self.viewController?.registerSelectedUsers()
    }
    
    // MARK: ViewModel method wrappers
    public func registerOperator(with userIds: [String]) {
        self.viewController?.viewModel?.registerAsOperators(userIds: userIds)
    }
}

extension GroupChannelRegisterOperatorViewProvider: SBURegisterOperatorViewModelDelegate {
    public func registerOperatorViewModel(_ viewModel: SBURegisterOperatorViewModel, didRegisterOperatorIds operatorIds: [String]) {
        self.eventHandlers.didRegisterOperatorsHandler?(operatorIds)
    }
    
    public func baseSelectedUserViewModel(_ viewModel: SBUBaseSelectUserViewModel, didChangeUserList users: [SBUUser]?, needsToReload: Bool) {
        guard let users = users else { return }
        StateImpactHandler.safeExecute { [weak self] in
            self?.members = users
        }
    }
    
    public func baseSelectedUserViewModel(_ viewModel: SBUBaseSelectUserViewModel, didUpdateSelectedUsers selectedUsers: [SBUUser]?) {
        guard let selectedUsers = selectedUsers else { return }
        StateImpactHandler.safeExecute { [weak self] in
            self?.selectedMembers = selectedUsers
        }
    }
}
    
extension GroupChannelRegisterOperatorViewProvider: SBUCommonViewModelDelegate {
    public func shouldUpdateLoadingState(_ isLoading: Bool) {
        StateImpactHandler.safeExecute { [weak self] in
            self?.isLoading = isLoading
        }
    }
    
    public func didReceiveError(_ error: SendbirdChatSDK.SBError?, isBlocker: Bool) {
        self.eventHandlers.errorHandler?(error)
    }
}

extension GroupChannelRegisterOperatorViewProvider: RegisterOperatorViewEventDelegate {
    func registerOperatorView(didSelectRowAt indexPath: IndexPath) {
        self.eventHandlers.selectRowHandler?(indexPath)
    }
}
