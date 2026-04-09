//
//  GroupChannelPushSettingsViewProvider.swift
//  SendbirdUIKit
//
//  Created by Celine Moon on 10/22/24.
//

import Foundation
import SwiftUI
import SendbirdChatSDK

/// Event handlers for the Group Channel Push Settings view.
public struct GroupChannelPushSettingsEventHandlers {

}

/// A provider that manages data and state for the Group Channel Push Settings view.
public class GroupChannelPushSettingsViewProvider: SendbirdUIProvider {
    // init properties
    var channelURL: String
    
    // SendbirdProvider protocol
    weak var viewController: SBUGroupChannelPushSettingsViewController?
    var eventHandlers = GroupChannelPushSettingsEventHandlers()
    
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
    
    func bind(viewController: SBUGroupChannelPushSettingsViewController) {
        viewController.swiftUIDelegate = self
        self.viewController = viewController
    }
}

extension GroupChannelPushSettingsViewProvider: SBUGroupChannelPushSettingsViewModelDelegate {
    public func groupChannelPushSettingsViewModel(_ viewModel: SBUGroupChannelPushSettingsViewModel, didChangeNotification pushTriggerOption: SendbirdChatSDK.GroupChannelPushTriggerOption) {
        
    }
    
    public func baseChannelSettingsViewModel(_ viewModel: SBUBaseChannelSettingsViewModel, didChangeChannel channel: SendbirdChatSDK.BaseChannel?, withContext context: SendbirdChatSDK.MessageContext) {
        
    }
    
    public func baseChannelSettingsViewModel(_ viewModel: SBUBaseChannelSettingsViewModel, shouldDismissForChannelSettings channel: SendbirdChatSDK.BaseChannel?) {
        
    }
    
    public func shouldUpdateLoadingState(_ isLoading: Bool) {
        
    }
    
    public func didReceiveError(_ error: SendbirdChatSDK.SBError?, isBlocker: Bool) {
        
    }
}

extension GroupChannelPushSettingsViewProvider: GroupChannelPushSettingsViewEventDelegate {
    
}
