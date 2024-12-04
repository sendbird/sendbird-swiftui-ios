//
//  OpenChannelSettingsViewProvider.swift
//  SendbirdUIKit
//
//  Created by Celine Moon on 10/22/24.
//

import Foundation
import SwiftUI
import SendbirdChatSDK

public struct OpenChannelSettingsEventHandlers {
    
}

public class OpenChannelSettingsViewProvider: SendbirdUIProvider {
    // init properties
    var channelURL: String
    
    // SendbirdUIProvider protocol
    weak var viewController: SBUOpenChannelSettingsViewController?
    var eventHandlers = OpenChannelSettingsEventHandlers()
    
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
    
    func bind(viewController: SBUOpenChannelSettingsViewController) {
        viewController.swiftUIDelegate = self
        self.viewController = viewController
    }
}

extension OpenChannelSettingsViewProvider: SBUOpenChannelSettingsViewModelDelegate {
    public func baseChannelSettingsViewModel(_ viewModel: SBUBaseChannelSettingsViewModel, didChangeChannel channel: SendbirdChatSDK.BaseChannel?, withContext context: SendbirdChatSDK.MessageContext) {
        
    }
    
    public func baseChannelSettingsViewModel(_ viewModel: SBUBaseChannelSettingsViewModel, shouldDismissForChannelSettings channel: SendbirdChatSDK.BaseChannel?) {
        
    }
    
    public func shouldUpdateLoadingState(_ isLoading: Bool) {
        
    }
    
    public func didReceiveError(_ error: SendbirdChatSDK.SBError?, isBlocker: Bool) {
        
    }
    
    public func openChannelSettingsViewModel(_ viewModel: SBUOpenChannelSettingsViewModel, didDeleteChannel channel: SendbirdChatSDK.OpenChannel) {
        
    }
}

extension OpenChannelSettingsViewProvider: OpenChannelSettingsViewEventDelegate {
    
}
