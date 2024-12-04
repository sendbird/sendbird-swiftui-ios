//
//  GroupChannelSettingsViewProvider.swift
//  SendbirdUIKit
//
//  Created by Celine Moon on 10/22/24.
//

import Foundation
import SwiftUI
import SendbirdChatSDK

public struct GroupChannelSettingsEventHandlers {
    
}

public class GroupChannelSettingsViewProvider: SendbirdUIProvider {
    // Init properties
    var channelURL: String
    
    // SendbirdProvider protocol
    weak var viewController: SBUGroupChannelSettingsViewController?
    var eventHandlers = GroupChannelSettingsEventHandlers()
    
    // MARK: Public Data Properties
    // Note: @Published properties can't be computed properties.
    
    // MARK: Public UI Properties (??)
    // public var theme: SBUGroupChannelListTheme
    
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
    
    func bind(viewController: SBUGroupChannelSettingsViewController) {
        viewController.swiftUIDelegate = self
        self.viewController = viewController
    }
}

extension GroupChannelSettingsViewProvider: SBUGroupChannelSettingsViewModelDelegate {
    public func groupChannelSettingsViewModel(_ viewModel: SBUGroupChannelSettingsViewModel, didLeaveChannel channel: SendbirdChatSDK.GroupChannel) {
        
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

extension GroupChannelSettingsViewProvider: GroupChannelSettingsViewEventDelegate {
    
}
