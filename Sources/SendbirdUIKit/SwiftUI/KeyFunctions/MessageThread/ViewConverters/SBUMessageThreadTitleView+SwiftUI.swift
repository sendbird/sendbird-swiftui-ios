//
//  SBUMessageThreadTitleView+SwiftUI.swift
//  SendbirdUIKit
//
//  Created by Damon Park on 7/6/24.
//

import UIKit
import SendbirdChatSDK

extension SBUMessageThreadTitleView {
    typealias ViewConverter = MessageThreadViewConverter.Header.TitleView
    
    var viewConverter: ViewConverter {
        SBViewConverterSet.MessageThread.header.titleView
    }
}

extension SBUMessageThreadTitleView {
    @discardableResult
    func applyViewConverter(_ viewType: ViewConverter.ViewType) -> Bool {
        guard let channel = self.channel as? GroupChannel else { return false }
        
        let tag = viewType.tag
        
        switch viewType {
        case .entireContent:
            return false
        case .titleLabel:
            let config = ViewConverter.TitleLabel.ViewConfig(channel: channel)
            
            guard let viewConverter = self.viewConverter.titleLabel.entireContent,
                  let hostingView = viewConverter(config)
            else { return false }
            
            hostingView.tag = tag
            hostingView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
            
            self.titleLabel.removeFromSuperview()
            self.stackView.viewWithTag(tag)?.removeFromSuperview()
            self.stackView.insertArrangedSubview(hostingView, at: 0)
            
            return true
            
        case .subtitleLabel:
            let config = ViewConverter.SubtitleLabel.ViewConfig(channel: channel)
            
            guard let viewConverter = self.viewConverter.subtitleLabel.entireContent,
                  let hostingView = viewConverter(config)
            else { return false }
            
            hostingView.tag = tag
            hostingView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
            
            self.channelNameLabel.removeFromSuperview()
            self.stackView.viewWithTag(tag)?.removeFromSuperview()
            self.stackView.insertArrangedSubview(hostingView, at: 1)
            
            return true
        }
    }
}
