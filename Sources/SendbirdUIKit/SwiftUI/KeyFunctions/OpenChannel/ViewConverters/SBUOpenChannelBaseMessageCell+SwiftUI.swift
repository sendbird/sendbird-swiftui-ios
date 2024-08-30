//
//  SBUOpenChannelBaseMessageCell+SwiftUI.swift
//  SendbirdSwiftUI
//
//  Created by Tez Park on 7/3/24.
//

import SwiftUI
import SendbirdChatSDK

extension SBUOpenChannelBaseMessageCell {
    typealias ViewConverter = OpenChannelViewConverter.List.TableView.RowView
    
    var viewConverter: ViewConverter {
        SBViewConverterSet.OpenChannel.list.tableView.rowView
    }
}

extension SBUOpenChannelBaseMessageCell {
    @discardableResult
    func applyViewConverter(_ viewType: ViewConverter.ViewType) -> Bool {
        guard let message = self.message else { return false }
        
        let tag = viewType.tag
        
        switch viewType {
        case .entireContent:
            guard let viewConverter = self.viewConverter.entireContent else { return false }
            
            let config = ViewConverter.ViewConfig(message: message)
            guard let hostingView = viewConverter(config) else { return false }
            
            self.stackView.removeFromSuperview()
            self.contentView.viewWithTag(tag)?.removeFromSuperview()
            
            hostingView.tag = tag
            self.contentView.addSubview(hostingView)
            
            if let contentBaseCell = self as? SBUOpenChannelContentBaseMessageCell {
                hostingView.addGestureRecognizer(contentBaseCell.contentLongPressRecognizer)
                hostingView.addGestureRecognizer(contentBaseCell.contentTapRecognizer)
            }
            
            hostingView.sbu_constraint_fill(equalTo: self.contentView)
            return true

        case .senderProfileImage:
            guard let contentBaseCell = self as? SBUOpenChannelContentBaseMessageCell,
                  let viewConverter = self.viewConverter.senderProfileImage.entireContent else {
                return false
            }
            
            let profileURL = message.sender?.profileURL ?? ""
            let config = ViewConverter.SenderProfileImage.ViewConfig(
                sender: message.sender,
                profileURL: profileURL
            )
            guard let hostingView = viewConverter(config) else { return false }
                
            contentBaseCell.profileView.removeFromSuperview()
            contentBaseCell.viewWithTag(tag)?.removeFromSuperview()
            
            hostingView.tag = tag
            contentBaseCell.profileBaseView.addSubview(hostingView)
            
            hostingView.sbu_constraint_fill(equalTo: contentBaseCell.profileBaseView)
            
            let tap = UITapGestureRecognizer(
                target: contentBaseCell,
                action: #selector(contentBaseCell.onTapUserProfileView(sender:))
            )
            hostingView.addGestureRecognizer(tap)
            hostingView.isUserInteractionEnabled = true
            return true

        case .adminMessage:
            guard let adminMessageCell = self as? SBUOpenChannelAdminMessageCell,
                  let viewConverter = self.viewConverter.adminMessage.entireContent,
                  let adminMessage = adminMessageCell.adminMessage else {
                return false
            }
            
            let config = ViewConverter.AdminMessage.ViewConfig(message: adminMessage)
            guard let hostingView = viewConverter(config) else { return false }
            
            adminMessageCell.messageLabel.removeFromSuperview()
            adminMessageCell.messageContentView.viewWithTag(tag)?.removeFromSuperview()
            
            hostingView.tag = tag

            adminMessageCell.messageContentView.addSubview(hostingView)
            hostingView.sbu_constraint_fill(equalTo: adminMessageCell.messageContentView)
            return true

        case .userMessage:
            guard let userMessageCell = self as? SBUOpenChannelUserMessageCell,
                  let viewConverter = self.viewConverter.userMessage.entireContent,
                  let userMessage = userMessageCell.userMessage else {
                return false
            }
            
            let config = ViewConverter.UserMessage.ViewConfig(message: userMessage)
            guard let hostingView = viewConverter(config) else { return false }
            
            userMessageCell.messageTextView.removeFromSuperview()
            userMessageCell.viewWithTag(tag)?.removeFromSuperview()
            
            hostingView.tag = tag
            
            hostingView.addGestureRecognizer(userMessageCell.contentLongPressRecognizer)
            hostingView.addGestureRecognizer(userMessageCell.contentTapRecognizer)
            
            let mainContainerView = userMessageCell.mainContainerView as? SBUSelectableStackView
            mainContainerView?.layer.cornerRadius = 0
            mainContainerView?.setTransparentBackgroundColor()
            mainContainerView?.insertArrangedSubview(hostingView, at: 0)
//            hostingView.sbu_constraint(lessThanOrEqualTo: userMessageCell, trailing: -12)
            return true

        case .fileMessage:
            guard let fileMessageCell = self as? SBUOpenChannelFileMessageCell,
                  let viewConverter = self.viewConverter.fileMessage.entireContent,
                  let fileMessage = fileMessageCell.fileMessage else {
                return false
            }
            
            let config = ViewConverter.FileMessage.ViewConfig(
                message: fileMessage,
                fileType: fileMessageCell.fileType,
                fileURL: fileMessage.url
            )
            guard let hostingView = viewConverter(config) else { return false }
            
            fileMessageCell.baseFileContentView.removeFromSuperview()
            fileMessageCell.viewWithTag(tag)?.removeFromSuperview()
            
            hostingView.tag = tag
            
            hostingView.addGestureRecognizer(fileMessageCell.contentLongPressRecognizer)
            hostingView.addGestureRecognizer(fileMessageCell.contentTapRecognizer)
            
            let mainContainerView = fileMessageCell.mainContainerView as? SBUSelectableStackView
            mainContainerView?.layer.cornerRadius = 0
            mainContainerView?.setTransparentBackgroundColor()
            
            mainContainerView?.insertArrangedSubview(hostingView, at: 0)
            // TODO: SwiftUI - 파일 타입별 처리
            return true
        }
        
        return false
    }
}
