//
//  SBUBaseMessageCell.MessageThread+SwiftUI.swift
//  SendbirdUIKit
//
//  Created by Damon Park on 7/7/24.
//

import UIKit

extension SBUBaseMessageCell {
    typealias ViewConverterForMessageThread = MessageThreadViewConverter.List.TableView.RowView
    var viewConverterForMessageThread: ViewConverterForMessageThread {
        SBViewConverterSet.MessageThread.list.tableView.rowView
    }
    
    @discardableResult
    func applyViewConverterForMessageThread(_ viewType: ViewConverterForMessageThread.ViewType) -> Bool {
        guard let message = self.message else { return false }
        
        let tag = viewType.tag
        
        switch viewType {
        case .entireContent:
            guard let viewConverterForMessageThread = self.viewConverterForMessageThread.entireContent else { return false }
            
            let config = ViewConverterForMessageThread.ViewConfig(message: message)
            guard let hostingView = viewConverterForMessageThread(config) else { return false }
            
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
                  let viewConverterForMessageThread = self.viewConverterForMessageThread.senderProfileImage.entireContent else {
                return false
            }
            
            let profileURL = message.sender?.profileURL ?? ""
            let config = ViewConverterForMessageThread.SenderProfileImage.ViewConfig(
                sender: message.sender,
                profileURL: profileURL
            )
            guard let hostingView = viewConverterForMessageThread(config) else { return false }
            
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
            
        case .userMessage:
            guard let userMessageCell = self as? SBUUserMessageCell,
                  let viewConverterForMessageThread = self.viewConverterForMessageThread.userMessage.entireContent,
                  let userMessage = userMessageCell.userMessage else {
                return false
            }
            
            let config = ViewConverterForMessageThread.UserMessage.ViewConfig(message: userMessage)
            guard let hostingView = viewConverterForMessageThread(config) else { return false }
            
            userMessageCell.messageTextView.removeFromSuperview()
            userMessageCell.viewWithTag(tag)?.removeFromSuperview()
            
            hostingView.tag = tag
            
            hostingView.addGestureRecognizer(userMessageCell.contentLongPressRecognizer)
            hostingView.addGestureRecognizer(userMessageCell.contentTapRecognizer)
            
            userMessageCell.mainContainerView.insertArrangedSubview(hostingView, at: 1)
            return true
            
        case .fileMessage:
            guard let fileMessageCell = self as? SBUFileMessageCell,
                  let viewConverterForMessageThread = self.viewConverterForMessageThread.fileMessage.entireContent,
                  let fileMessage = fileMessageCell.fileMessage else {
                return false
            }
            
            let config = ViewConverterForMessageThread.FileMessage.ViewConfig(
                message: fileMessage,
                fileType: fileMessageCell.fileType,
                fileURL: fileMessage.url
            )
            guard let hostingView = viewConverterForMessageThread(config) else { return false }
            
            fileMessageCell.baseFileContentView.removeFromSuperview()
            fileMessageCell.viewWithTag(tag)?.removeFromSuperview()
            
            hostingView.tag = tag
            
            hostingView.addGestureRecognizer(fileMessageCell.contentLongPressRecognizer)
            hostingView.addGestureRecognizer(fileMessageCell.contentTapRecognizer)
            
            fileMessageCell.mainContainerView.insertArrangedSubview(hostingView, at: 0)
            return true
            
        case .multipleFilesMessage:
            guard let mfmCell = self as? SBUMultipleFilesMessageCell,
                  let viewConverterForMessageThread = self.viewConverterForMessageThread.multipleFilesMessage.entireContent,
                  let mfmMessage = mfmCell.multipleFilesMessage else {
                return false
            }
            
            let config = ViewConverterForMessageThread.MultipleFilesMessage.ViewConfig(message: mfmMessage)
            guard let hostingView = viewConverterForMessageThread(config) else { return false }

            mfmCell.containerView.removeFromSuperview()
            mfmCell.viewWithTag(tag)?.removeFromSuperview()
            
            hostingView.tag = tag
            
            hostingView.addGestureRecognizer(mfmCell.contentLongPressRecognizer)
            hostingView.addGestureRecognizer(mfmCell.contentTapRecognizer)
                
            mfmCell.mainContainerView.insertArrangedSubview(hostingView, at: 0)
                
            mfmCell.mainContainerView.sbu_constraint(
                width: hostingView.intrinsicContentSize.width
            )
            return true
        }
        return false
    }
}
