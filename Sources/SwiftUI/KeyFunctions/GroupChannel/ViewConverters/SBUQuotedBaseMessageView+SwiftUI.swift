//
//  SBUQuotedBaseMessageView+SwiftUI.swift
//  SendbirdUIKit
//
//  Created by Celine Moon on 3/10/25.
//

import Foundation
import SendbirdChatSDK
import UIKit

extension SBUQuotedBaseMessageView {
    typealias ViewConverter = GroupChannelViewConverter.List.TableView.RowView
    var viewConverter: ViewConverter {
        SBViewConverterSet.GroupChannel.list.tableView.rowView
    }
    
    @discardableResult
    func applyViewConverter(
        _ viewType: ViewConverter.ViewType,
        configuration: SBUQuotedBaseMessageViewParams
    ) -> Bool {
        switch viewType {
        // case .quotedUserMessage:
            // todo
            
        case .quotedFileMessage:
            guard let quotedFileMessageView = self as? SBUQuotedFileMessageView,
                  let viewConverter = self.viewConverter.quotedFileMessage.entireContent,
                  let parentFileMessage = configuration.message.parentMessage as? FileMessage else {
                return false
            }
            
            let fileType = SBUUtils.getFileType(by: parentFileMessage)
            let config = ViewConverter.QuotedFileMessage.ViewConfig(
                message: parentFileMessage,
                fileType: fileType,
                fileURL: parentFileMessage.url
            )
            guard let hostingView = viewConverter(config) else { return false }
            
            configureQuotedFileMessageView(quotedFileMessageView, hostingView: hostingView)
            return true
            
        case .quotedMultipleFilesMessage:
            guard let quotedFileMessageView = self as? SBUQuotedFileMessageView,
                  let viewConverter = self.viewConverter.quotedMultipleFilesMessage.entireContent,
                  let parentMFM = configuration.message.parentMessage as? MultipleFilesMessage else {
                return false
            }
            
            let param = parentMFM.messageParams as? MultipleFilesMessageCreateParams
            let config = ViewConverter.QuotedMultipleFilesMessage.ViewConfig(
                message: parentMFM,
                files: parentMFM.files,
                pendingFiles: param?.uploadableFileInfoList
            )
            
            guard let hostingView = viewConverter(config) else { return false }
            
            configureQuotedFileMessageView(quotedFileMessageView, hostingView: hostingView)
            return true
        
        default:
            return false
        }
    }
}

extension SBUQuotedBaseMessageView {
    private func configureQuotedFileMessageView(
        _ quotedFileMessageView: SBUQuotedFileMessageView,
        hostingView: UIView
    ) {
        quotedFileMessageView.messageFileView.subviews.forEach { $0.removeFromSuperview() }
        quotedFileMessageView.viewWithTag(tag)?.removeFromSuperview()
        
        hostingView.tag = tag
        quotedFileMessageView.messageFileView.addSubview(hostingView)
        
        hostingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingView.topAnchor.constraint(equalTo: quotedFileMessageView.messageFileView.topAnchor),
            hostingView.bottomAnchor.constraint(equalTo: quotedFileMessageView.messageFileView.bottomAnchor),
            hostingView.leadingAnchor.constraint(equalTo: quotedFileMessageView.messageFileView.leadingAnchor),
            hostingView.trailingAnchor.constraint(equalTo: quotedFileMessageView.messageFileView.trailingAnchor)
        ])
    }
}
