//
//  SBUParentMessageInfoView+SwiftUI.swift
//  SendbirdUIKit
//
//  Created by Damon Park on 7/7/24.
//

import UIKit
import SendbirdChatSDK

extension SBUParentMessageInfoView {
    typealias ViewConverter = MessageThreadViewConverter.ParentInfo
    var viewConverter: ViewConverter {
        SBViewConverterSet.MessageThread.parentInfo
    }

    @discardableResult
    func applyViewConverter(_ viewType: ViewConverter.ViewType) -> Bool {
        guard let message = self.message else { return false }
        
        let tag = viewType.tag
        
        switch viewType {
        case .entireContent:
            let config = ViewConverter.ViewConfig(
                parentMessage: message
            )
            guard let hostingView = self.viewConverter.entireContent?(config) else { return false }
            
            self.viewWithTag(tag)?.removeFromSuperview()
            
            hostingView.tag = tag
            self.addSubview(hostingView)
            
            self.backgroundColor = .clear
            hostingView.sbu_constraint_fill(equalTo: self)

            return true
            
        case .profileView:
            guard let viewConverter = self.viewConverter.profileView.entireContent,
                  let hostingView = viewConverter(.init(parentView: self, parentMessage: message))
            else { return false }
            
            self.profileView.removeFromSuperview()
            self.profileBaseView.viewWithTag(tag)?.removeFromSuperview()
            
            hostingView.tag = tag
            self.profileBaseView.addSubview(hostingView)
            
            hostingView
                .sbu_constraint_fill(equalTo: self.profileBaseView)
                .sbu_constraint(width: 34, height: 34, priority: .defaultLow)
            
            hostingView.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .horizontal)
            
            return true
            
        case .userNameLabel:
            guard let viewConverter = self.viewConverter.userNameLabel.entireContent,
                  let hostingView = viewConverter(.init(parentView: self, parentMessage: message))
            else { return false }
            
            self.userNameLabel.removeFromSuperview()
            self.senderVStackView.viewWithTag(tag)?.removeFromSuperview()
            
            hostingView.tag = tag
            self.senderVStackView.insertArrangedSubview(hostingView, at: 0)
            self.senderVStackView.alignment = .leading
            
            return true
            
        case .dateLabel:
            guard let viewConverter = self.viewConverter.dateLabel.entireContent,
                  let hostingView = viewConverter(.init(parentView: self, parentMessage: message))
            else { return false }
            
            self.dateLabel.removeFromSuperview()
            self.senderVStackView.viewWithTag(tag)?.removeFromSuperview()
            
            hostingView.tag = tag
            self.senderVStackView.insertArrangedSubview(hostingView, at: 1)
            self.senderVStackView.alignment = .leading
            
            return true
            
        case .moreButton:
            guard let viewConverter = self.viewConverter.moreButton.entireContent,
                  let hostingView = viewConverter(.init(parentView: self, parentMessage: message))
            else { return false }
            
            self.moreButton?.removeFromSuperview()
            self.moreButtonBaseView.viewWithTag(tag)?.removeFromSuperview()
            
            hostingView.tag = tag
            self.moreButtonBaseView.addSubview(hostingView)
            
            hostingView
                .sbu_constraint_fill(equalTo: self.moreButtonBaseView)
            
            hostingView.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .horizontal)
            hostingView.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .vertical)
            
            return true
            
        case .replyLabel:
            guard let viewConverter = self.viewConverter.replyLabel.entireContent,
                  let hostingView = viewConverter(.init(parentView: self, parentMessage: message))
            else { return false }
            
            self.replyLabel.removeFromSuperview()
            self.viewWithTag(tag)?.removeFromSuperview()
            
            hostingView.tag = tag
            self.addSubview(hostingView)
            
            // label top line
            self.replyLabelTopAnchorConstraint = hostingView.sbu_constraint_equalTo_v2(
                topAnchor: self.replySeparateLine.bottomAnchor,
                top: 8
            ).first
            
            hostingView
                .sbu_constraint(equalTo: self, leading: 16)
                .sbu_constraint(equalTo: self, trailing: -16, priority: .defaultLow)
            
            // label bottom line
            self.bottomSeparateLineTopAnchorConstraint = bottomSeparateLine.sbu_constraint_equalTo_v2(
                topAnchor: hostingView.bottomAnchor,
                top: 8
            ).first
            
            hostingView.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .horizontal)
            
            self.updateLayouts()
            
            return true
        case .messageTextView:
            guard let viewConverter = self.viewConverter.messageTextView.entireContent,
                  let hostingView = viewConverter(.init(parentView: self, parentMessage: message))
            else { return false }
            
            self.messageTextView.removeFromSuperview()
            self.contentVStackView.viewWithTag(tag)?.removeFromSuperview()
            
            hostingView.tag = tag
            self.contentVStackView.insertArrangedSubview(hostingView, at: 0)
            
            if let superViewWidth = self.superview?.frame.width, self.viewConverter.webView.entireContent != nil {
                self.messageTextViewWidthConstraint?.isActive = false
                self.messageTextViewWidthConstraint = hostingView.sbu_constraint_lessThan_v2(width: superViewWidth - (Constants.verticalSideMarginSize * 2)).first
                  self.messageTextViewWidthConstraint?.isActive = true
            }
            
            return true
        case .fileContentView:
            guard let fileMessage = message as? FileMessage else { return false }
            guard let viewConverter = self.viewConverter.fileContentView.entireContent,
                  let hostingView = viewConverter(.init(parentView: self, fileMessage: fileMessage))
            else { return false }
            
            self.messageTextView.removeFromSuperview()
            self.contentVStackView.viewWithTag(tag)?.removeFromSuperview()
            
            hostingView.tag = tag
            self.contentVStackView.insertArrangedSubview(hostingView, at: 0)
            
            return true
            
        case .multipleFileContentView:
            guard let multipleFileMessage = message as? MultipleFilesMessage else { return false }
            guard let viewConverter = self.viewConverter.multipleFileContentView.entireContent,
                  let hostingView = viewConverter(.init(parentView: self, multipleFilesMessage: multipleFileMessage))
            else { return false }
            
            self.fileCollectionView.removeFromSuperview()
            self.contentVStackView.viewWithTag(tag)?.removeFromSuperview()
            
            hostingView.tag = tag
            self.contentVStackView.insertArrangedSubview(hostingView, at: 0)
            
            return true
            
        case .webView:
            guard let viewConverter = self.viewConverter.webView.entireContent,
                  let hostingView = viewConverter(.init(parentView: self, parentMessage: message))
            else { return false }
            
            self.webView.removeFromSuperview()
            self.contentVStackView.viewWithTag(tag)?.removeFromSuperview()
            
            hostingView.tag = tag
            self.contentVStackView.insertArrangedSubview(hostingView, at: 1)
            
            return true
            
        case .reactionView:
            guard let viewConverter = self.viewConverter.reactionView.entireContent,
                  let hostingView = viewConverter(.init(parentView: self, parentMessage: message))
            else { return false }
            
            self.reactionView.removeFromSuperview()
            self.viewWithTag(tag)?.removeFromSuperview()
            
            hostingView.tag = tag
            self.addSubview(hostingView)
            
            self.contentVStackView
                .sbu_constraint_equalTo(bottomAnchor: hostingView.topAnchor, bottom: 0)
            
            hostingView
                .sbu_constraint(equalTo: self, leading: 8)
                .sbu_constraint(equalTo: self, trailing: -8, priority: .defaultLow)
                .sbu_constraint_equalTo(bottomAnchor: self.replySeparateLine.topAnchor, bottom: 8)
            
            hostingView.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .horizontal)
            
            return true
        }
    }
}
