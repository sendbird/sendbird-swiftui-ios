//
//  SBUOpenChannelTitleView+SwiftUI.swift
//  SendbirdSwiftUI
//
//  Created by Tez Park on 7/4/24.
//

import SendbirdChatSDK
import UIKit

extension SBUChannelTitleView {
    typealias ViewConverterForOpen = OpenChannelViewConverter.Header.TitleView
    
    var viewConverterForOpen: ViewConverterForOpen {
        SBViewConverterSet.OpenChannel.header.titleView
    }
}

extension SBUChannelTitleView {
    @discardableResult
    func applyViewConverterForOpen(_ viewType: ViewConverterForOpen.ViewType) -> Bool {
        guard let channel = self.channel as? OpenChannel else { return false }
        
        switch viewType {
        case .entireContent:
            return false
        case .coverImage:
            let config = ViewConverterForOpen.CoverImage.ViewConfig.init(
                channel: channel,
                coverImage: channel.coverURL
            )
            
            if let viewConverter = self.viewConverterForOpen.coverImage.entireContent,
               let hostingView = viewConverter(config) {
                let tag = ViewConverterForOpen.ViewType.coverImage.tag
                
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
            
        case .titleLabel:
            let config = ViewConverterForOpen.TitleLabel.ViewConfig.init(channel: channel)
            if let viewConverter = self.viewConverterForOpen.titleLabel.entireContent,
               let hostingView = viewConverter(config) {
                let tag = ViewConverterForOpen.ViewType.titleLabel.tag

                self.titleLabel.removeFromSuperview()
                self.stackView.viewWithTag(tag)?.removeFromSuperview()

                hostingView.tag = tag
                hostingView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
                self.stackView.insertArrangedSubview(hostingView, at: 0)
                stackView.alignment = .leading

                return true
            }
            
        case .subtitleLabel:
            let config = ViewConverterForOpen.SubtitleLabel.ViewConfig.init(
                channel: channel,
                participantCount: channel.participantCount
            )
            if let viewConverter = self.viewConverterForOpen.subtitleLabel.entireContent,
               let hostingView = viewConverter(config) {
                let tag = ViewConverterForOpen.ViewType.subtitleLabel.tag
                
                self.statusField.removeFromSuperview()
                self.stackView.viewWithTag(tag)?.removeFromSuperview()

                hostingView.tag = tag
                hostingView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
                self.stackView.insertArrangedSubview(hostingView, at: 1)
                stackView.alignment = .leading
                return true
            }
        }
        return false
    }
}
