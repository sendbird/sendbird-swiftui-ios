//
//  SBUGroupChannelCell+SwiftUI.swift
//  SendbirdSwiftUI
//
//  Created by Tez Park on 6/25/24.
//

import SwiftUI
import SendbirdChatSDK

extension SBUGroupChannelCell {
    typealias ViewConverter = GroupChannelListViewConverter.List.TableView.ChannelCell
    
    var viewConverter: ViewConverter {
        SBViewConverterSet.GroupChannelList.list.tableView.channelCell
    }
}

extension SBUGroupChannelCell {
    func applyViewConverter(_ viewType: ViewConverter.ViewType) -> Bool {
        guard let groupChannel = self.channel as? GroupChannel else { return false }
        
        let tag = viewType.tag
        
        switch viewType {
        case .entireContent:
            let config = ViewConverter.ViewConfig.init(channel: groupChannel)
            return configureCellForSwiftUI(config, tag: tag)
            
        case .coverImage:
            let config = ViewConverter.CoverImage.ViewConfig.init(
                channel: groupChannel,
                imageSize: CGSize(width: self.coverImageSize, height: self.coverImageSize),
                coverURL: groupChannel.isBroadcast ? nil : groupChannel.coverURL,
                isBroadcastChannel: groupChannel.isBroadcast
            )
            return configureCoverImageForSwiftUI(config, tag: tag)
            
        case .channelName:
            let channelName = SBUUtils.isValid(channelName: groupChannel.name)
            ? groupChannel.name
            : SBUUtils.generateChannelName(channel: groupChannel)
            
            let config = ViewConverter.ChannelName.ViewConfig.init(
                channel: groupChannel,
                channelName: channelName
            )
            return configureChannelNameForSwiftUI(config, tag: tag)
            
        case .channelPreview:
            let config = ViewConverter.ChannelPreview.ViewConfig.init(
                channel: groupChannel,
                previewMessage: self.generatePreviewMessage()
            )
            return configureChannelPreviewForSwiftUI(config, tag: tag)
            
        case .unreadCount:
            let config = ViewConverter.UnreadCount.ViewConfig.init(
                channel: groupChannel,
                unreadCount: groupChannel.unreadMessageCount
            )
            return configureUnreadCountViewForSwiftUI(config, tag: tag)
        }
    }
    
    private func generatePreviewMessage() -> String {
        guard let channel = self.channel as? GroupChannel else { return "" }
        
        switch channel.lastMessage {
        case let userMessage as UserMessage:
            if userMessage.hasMessageTemplate == true {
                return SBUStringSet.GroupChannel.Preview.messageTemplate
            } else {
                return userMessage.message
            }
        case let fileMessage as FileMessage:
            return SBUUtils.getFileTypePreviewString(by: fileMessage.type)
        case let adminMessage as AdminMessage:
            return adminMessage.message
        case _ as MultipleFilesMessage:
            return SBUStringSet.GroupChannel.Preview.multipleFiles
        default:
            return ""
        }
    }
    
    private func configureCellForSwiftUI(
        _ config: ViewConverter.ViewConfig,
        tag: Int
    ) -> Bool {
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
        return false
    }
        
    private func configureCoverImageForSwiftUI(
        _ config: ViewConverter.CoverImage.ViewConfig,
        tag: Int
    ) -> Bool {
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
        return false
    }
    
    private func configureChannelNameForSwiftUI(
        _ config: ViewConverter.ChannelName.ViewConfig,
        tag: Int
    ) -> Bool {
        if let channelNameViewConverter = self.viewConverter.channelName.entireContent,
           let hostingView = channelNameViewConverter(config) {
            self.titleLabel.removeFromSuperview()
            self.titleStackView.viewWithTag(tag)?.removeFromSuperview()
            
            hostingView.tag = tag
            hostingView.sbu_constraint(
                width: hostingView.intrinsicContentSize.width,
                height: hostingView.intrinsicContentSize.height
            )
            self.titleStackView.insertArrangedSubview(hostingView, at: 0)
            return true
        }
        return false
    }
    
    private func configureChannelPreviewForSwiftUI(
        _ config: ViewConverter.ChannelPreview.ViewConfig,
        tag: Int
    ) -> Bool {
        if let channelPreviewViewConverter = self.viewConverter.channelPreview.entireContent,
           let hostingView = channelPreviewViewConverter(config) {
            
            self.messageLabel.removeFromSuperview()
            self.messageStackView.viewWithTag(tag)?.removeFromSuperview()
            
            hostingView.tag = tag
            self.messageStackView.insertArrangedSubview(hostingView, at: 0)
            
            return true
        }
        return false
    }
    
    private func configureUnreadCountViewForSwiftUI(
        _ config: ViewConverter.UnreadCount.ViewConfig,
        tag: Int
    ) -> Bool {
        if let unreadCountViewConverter = self.viewConverter.unreadCount.entireContent,
           let hostingView = unreadCountViewConverter(config) {
            
            self.unreadCount.removeFromSuperview()
            self.messageStackView.viewWithTag(tag)?.removeFromSuperview()

            hostingView.tag = tag
            hostingView.sbu_constraint(
                width: hostingView.intrinsicContentSize.width,
                height: hostingView.intrinsicContentSize.height
            )
            self.messageStackView.addArrangedSubview(hostingView)
            return true
        }
        return false
    }
}
