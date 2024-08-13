//
//  SBUBaseMessageCell+SwiftUI.swift
//  SendbirdUIKit
//
//  Created by Celine Moon on 7/3/24.
//

import UIKit
import SendbirdChatSDK

extension SBUBaseMessageCell {
    typealias ViewConverter = GroupChannelViewConverter.List.TableView.RowView
    var viewConverter: ViewConverter {
        SBViewConverterSet.GroupChannel.list.tableView.rowView
    }
    
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
            
            if let contentBaseCell = self as? SBUContentBaseMessageCell {
                hostingView.addGestureRecognizer(contentBaseCell.contentLongPressRecognizer)
                hostingView.addGestureRecognizer(contentBaseCell.contentTapRecognizer)
            }
            
            hostingView.sbu_constraint_fill(equalTo: self.contentView)
            return true
            
        case .senderProfileImage:
            guard let contentBaseCell = self as? SBUContentBaseMessageCell,
                  let viewConverter = self.viewConverter.senderProfileImage.entireContent else {
                return false
            }
            
            let profileURL = message.sender?.profileURL ?? ""
            let config = ViewConverter.SenderProfileImage.ViewConfig(
                sender: message.sender,
                profileURL: profileURL
            )
            guard let hostingView = viewConverter(config) else { return false }
            
            contentBaseCell.profilesStackView.removeFromSuperview()
            contentBaseCell.profileView.removeFromSuperview()
            contentBaseCell.viewWithTag(tag)?.removeFromSuperview()
            
            hostingView.tag = tag
            contentBaseCell.contentHStackView.insertArrangedSubview(hostingView, at: 0)
            
            hostingView.sbu_constraint(
                width: hostingView.intrinsicContentSize.width,
                height: hostingView.intrinsicContentSize.height
            )
            
            let tap = UITapGestureRecognizer(
                target: contentBaseCell,
                action: #selector(contentBaseCell.onTapUserProfileView(sender:))
            )
            hostingView.addGestureRecognizer(tap)
            hostingView.isUserInteractionEnabled = true
            return true
            
        case .adminMessage:
            guard let adminMessageCell = self as? SBUAdminMessageCell,
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
            guard let userMessageCell = self as? SBUUserMessageCell,
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
            
            userMessageCell.mainContainerView.layer.cornerRadius = 0
            userMessageCell.mainContainerView.setTransparentBackgroundColor()
            
            userMessageCell.mainContainerView.insertArrangedSubview(hostingView, at: 1)
            return true
            
        case .fileMessage:
            guard let fileMessageCell = self as? SBUFileMessageCell,
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
            
            fileMessageCell.mainContainerView.layer.cornerRadius = 0
            fileMessageCell.mainContainerView.setTransparentBackgroundColor()
            
            fileMessageCell.mainContainerView.insertArrangedSubview(hostingView, at: 0)
            return true
            
        case .multipleFilesMessage:
            guard let mfmCell = self as? SBUMultipleFilesMessageCell,
                  let viewConverter = self.viewConverter.multipleFilesMessage.entireContent,
                  let mfmMessage = mfmCell.multipleFilesMessage else {
                return false
            }
            
            let param = mfmMessage.messageParams as? MultipleFilesMessageCreateParams
            let config = ViewConverter.MultipleFilesMessage.ViewConfig(
                message: mfmMessage,
                files: mfmMessage.files,
                pendingFiles: param?.uploadableFileInfoList
            )
            guard let hostingView = viewConverter(config) else { return false }

            mfmCell.containerView.removeFromSuperview()
            mfmCell.viewWithTag(tag)?.removeFromSuperview()
            
            hostingView.tag = tag
            
            hostingView.addGestureRecognizer(mfmCell.contentLongPressRecognizer)
            hostingView.addGestureRecognizer(mfmCell.contentTapRecognizer)
                
            mfmCell.mainContainerView.layer.cornerRadius = 0
            mfmCell.mainContainerView.setTransparentBackgroundColor()
            
            mfmCell.mainContainerView.insertArrangedSubview(hostingView, at: 0)
                
            mfmCell.mainContainerView.sbu_constraint(
                width: hostingView.intrinsicContentSize.width
            )
            return true
            
        case .typingMessage:
            guard let typingMessageCell = self as? SBUTypingIndicatorMessageCell,
                  let viewConverter = self.viewConverter.typingMessage.entireContent,
                  let typingMessage = typingMessageCell.typingMessage,
                  let typingInfo = typingMessage.typingIndicatorInfo else {
                return false
            }
            
            let config = ViewConverter.TypingIndicator.ViewConfig(typingInfo: typingInfo)
            guard let hostingView = viewConverter(config) else { return false }
            
            typingMessageCell.typingBubbleView.removeFromSuperview()
            typingMessageCell.viewWithTag(tag)?.removeFromSuperview()
                        
            hostingView.tag = tag
            
            typingMessageCell.mainContainerView.layer.cornerRadius = 0
            typingMessageCell.mainContainerView.setTransparentBackgroundColor()
            
            typingMessageCell.mainContainerView.insertArrangedSubview(hostingView, at: 0)
            return true
        }
        return false
    }
}
