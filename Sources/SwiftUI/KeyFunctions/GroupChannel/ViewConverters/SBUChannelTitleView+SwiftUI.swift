//
//  SBUChannelTitleView+SwiftUI.swift
//  SendbirdUIKit
//
//  Created by Celine Moon on 7/1/24.
//

import UIKit
import SendbirdChatSDK

extension SBUChannelTitleView {
    typealias ViewConverter = GroupChannelViewConverter.Header.TitleView
    
    var viewConverter: ViewConverter {
        SBViewConverterSet.GroupChannel.header.titleView
    }
}

extension SBUChannelTitleView {
    @discardableResult
    func applyViewConverter(_ viewType: ViewConverter.ViewType) -> Bool {
        guard let channel = self.channel as? GroupChannel else { return false }
        
        switch viewType {
        case .entireContent:
            return false
        case .coverImage:
            let config = ViewConverter.CoverImage.ViewConfig.init(
                channel: channel,
                coverURL: channel.isBroadcast ? nil : channel.coverURL
            )
            
            if let viewConverter = self.viewConverter.coverImage.entireContent,
               let hostingView = viewConverter(config) {
                let tag = ViewConverter.ViewType.coverImage.tag
                
                // setup view
                self.coverImage.removeFromSuperview()
                self.contentView.viewWithTag(tag)?.removeFromSuperview()
                
                hostingView.tag = tag
                self.contentView.insertSubview(hostingView, at: 0)
                
                // setup layout
                hostingView
                    .sbu_constraint_equalTo(
                        leftAnchor: self.contentView.leftAnchor,
                        left: 5
                    )
                    .sbu_constraint(
                        width: hostingView.intrinsicContentSize.width,
                        height: hostingView.intrinsicContentSize.height
                    )
                    .sbu_constraint(equalTo: self, centerY: 0)
                
                self.stackView
                    .sbu_constraint_equalTo(
                        leftAnchor: hostingView.rightAnchor,
                        left: 8,
                        rightAnchor: contentView.rightAnchor,
                        right: 5,
                        centerYAnchor: self.centerYAnchor,
                        centerY: 0
                    )
                    .sbu_constraint(height: kCoverImageSize)
                return true
            }
            return false 
        case .titleLabel:
            let config = ViewConverter.TitleLabel.ViewConfig.init(channel: channel)
            if let viewConverter = self.viewConverter.titleLabel.entireContent,
               let hostingView = viewConverter(config) {
                let tag = ViewConverter.ViewType.titleLabel.tag

                self.titleLabel.removeFromSuperview()
                self.stackView.viewWithTag(tag)?.removeFromSuperview()

                hostingView.tag = tag
                hostingView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
                self.stackView.insertArrangedSubview(hostingView, at: 0)
                stackView.alignment = .leading
                
                return true
            }
            return false
            
        case .statusView:
            let config = ViewConverter.StatusView.ViewConfig.init(channel: channel)
            if let viewConverter = self.viewConverter.statusView.entireContent,
               let hostingView = viewConverter(config) {
                let tag = ViewConverter.ViewType.statusView.tag
                
                self.statusField.removeFromSuperview()
                self.stackView.viewWithTag(tag)?.removeFromSuperview()

                hostingView.tag = tag
                hostingView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
                self.stackView.insertArrangedSubview(hostingView, at: 1)
                stackView.alignment = .leading
            }
            return false
        }
    }
}
