//
//  SBUOpenChannelCell+SwiftUI.swift
//  SendbirdUIKit
//
//  Created by Kai Lee on 6/28/24.
//

import SwiftUI
import SendbirdChatSDK

extension SBUOpenChannelCell {
    typealias ViewConverter = OpenChannelListViewConverter.List.TableView.ChannelCell
    
    var viewConverter: ViewConverter {
        SBViewConverterSet.OpenChannelList.list.tableView.channelCell
    }
}

extension SBUOpenChannelCell {
    func applyViewConverter(_ viewType: ViewConverter.ViewType) -> Bool {
        guard let openChannel = self.channel as? OpenChannel else {
            return false
        }
        
        let tag = viewType.tag
        
        switch viewType {
        case .entireContent:
            let config = ViewConverter.ViewConfig(channel: openChannel)
            if let entireCellConverter = self.viewConverter.entireContent,
               let hostingView = entireCellConverter(config) {
                
                // remove base container
                self.contentStackView.removeFromSuperview()
                self.contentView.viewWithTag(tag)?.removeFromSuperview()
                
                // add hostingView as subview of contentView
                hostingView.tag = tag
                self.contentView.addSubview(hostingView)
                
                hostingView.sbu_constraint_fill(equalTo: self.contentView)
                
                return true
            }
            
        case .coverImage:
            let config = ViewConverter.CoverImage.ViewConfig(
                channel: openChannel,
                imageSize: CGSize(width: self.coverImageSize, height: self.coverImageSize),
                coverURL: openChannel.coverURL
            )
            if let coverImageConverter = self.viewConverter.coverImage.entireContent,
               let hostingView = coverImageConverter(config) {
                
                self.coverImage.removeFromSuperview()
                self.contentStackView.viewWithTag(tag)?.removeFromSuperview()
                
                hostingView.tag = tag
                hostingView.sbu_constraint(
                    width: hostingView.intrinsicContentSize.width,
                    height: hostingView.intrinsicContentSize.height
                )
                self.contentStackView.insertArrangedSubview(hostingView, at: 0)
                
                return true
            }
            
        case .channelName:
            let channelName = openChannel.name.isEmpty
            ? SBUStringSet.Open_Channel_Name_Default
            : openChannel.name
            
            let config = ViewConverter.ChannelName.ViewConfig(
                channel: openChannel,
                channelName: channelName
            )
            if let titleViewConverter = self.viewConverter.channelName.entireContent,
               let hostingView = titleViewConverter(config) {
                
                self.titleLabel.removeFromSuperview()
                
                // Without it, the height is fixed to 22 by the default implementation of the superview
                self.titleStackView.sbu_constraint_greaterThan(height: 22)

                self.titleStackView.viewWithTag(tag)?.removeFromSuperview()
                
                hostingView.tag = tag
                hostingView.sbu_constraint(
                    width: hostingView.intrinsicContentSize.width,
                    height: hostingView.intrinsicContentSize.height
                )
                self.titleStackView.insertArrangedSubview(hostingView, at: 0)
                
                return true
            }
            
        case .channelPreview:
            let previewMessage = openChannel.participantCount.unitFormattedString
            
            let config = ViewConverter.ChannelPreview.ViewConfig(
                channel: openChannel,
                previewMessage: previewMessage
            )
            if let channelPreviewConverter = self.viewConverter.channelPreview.entireContent,
               let hostingView = channelPreviewConverter(config) {
                
                self.participantIcon.removeFromSuperview()
                self.participantCountLabel.removeFromSuperview()
                self.participantStackView.viewWithTag(tag)?.removeFromSuperview()
                
                hostingView.tag = tag
                hostingView.sbu_constraint(
                    width: hostingView.intrinsicContentSize.width,
                    height: hostingView.intrinsicContentSize.height
                )
                self.participantStackView.insertArrangedSubview(hostingView, at: 0)
                
                return true
            }
        }
        return false
    }
}
