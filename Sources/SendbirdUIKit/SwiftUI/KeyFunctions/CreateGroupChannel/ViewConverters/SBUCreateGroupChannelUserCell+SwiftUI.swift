//
//  SBUCreateGroupChannelUserCell+SwiftUI.swift
//  SendbirdSwiftUI
//
//  Created by Tez Park on 7/7/24.
//

import Foundation
import UIKit

extension SBUUserCell {
    typealias ViewConverter = CreateGroupChannelViewConverter.List.TableView.RowView
    var viewConverter: ViewConverter {
        SBViewConverterSet.CreateGroupChannel.list.tableView.rowView
    }
    
    @discardableResult
    func applyViewConverter(_ viewType: ViewConverter.ViewType) -> Bool {
        let tag = viewType.tag
        guard let user = self.user else { return false }
        
        switch viewType {
        case .entireContent:
            guard let viewConverter = self.viewConverter.entireContent else { return false }
            let config = ViewConverter.ViewConfig.init(
                user: user,
                isChecked: self.isChecked,
                operatorMode: self.operatorMode
            )
            guard let hostingView = viewConverter(config) else { return false }
            
            self.baseStackView.removeFromSuperview()
            self.contentView.viewWithTag(tag)?.removeFromSuperview()
            
            hostingView.tag = tag
            self.contentView.addSubview(hostingView)
            
            hostingView.addGestureRecognizer(
                .init(
                    target: self,
                    action: #selector(self.onTapContentView(sender:))
                )
            )
            
            hostingView.sbu_constraint_fill(equalTo: self.contentView)
            return true
        case .profileImage:
            guard let viewConverter = self.viewConverter.profileImage.entireContent else { return false }
            let config = ViewConverter.ProfileImage.ViewConfig.init(
                user: user,
                profileURL: user.profileURL ?? "",
                isChecked: self.isChecked,
                operatorMode: self.operatorMode
            )
            guard let hostingView = viewConverter(config) else { return false }
            
            self.userImageView.removeFromSuperview()
            self.viewWithTag(tag)?.removeFromSuperview()
            
            hostingView.tag = tag
            self.baseStackView.insertArrangedSubview(hostingView, at: 0)
            
            hostingView.sbu_constraint(
                width: hostingView.intrinsicContentSize.width
            )

            // TODO: SwiftUI - touch event 가 tableView didSelectRow 에서 먹어버림
//            hostingView.addGestureRecognizer(
//                .init(
//                    target: self,
//                    action: #selector(self.onTapUserProfileView(sender:))
//                )
//            )
            return true
        case .userNameLabel:
            guard let viewConverter = self.viewConverter.userNameLabel.entireContent else { return false }
            let config = ViewConverter.UserNameLabel.ViewConfig.init(
                user: user,
                nickname: user.refinedNickname(),
                isChecked: self.isChecked,
                operatorMode: self.operatorMode
            )
            guard let hostingView = viewConverter(config) else { return false }
            
            self.nicknameLabel.removeFromSuperview()
            self.viewWithTag(tag)?.removeFromSuperview()
            
            hostingView.tag = tag
            self.baseStackView.insertArrangedSubview(hostingView, at: 1)
            
            hostingView.setContentHuggingPriority(.required, for: .horizontal)
            
            return true
        case .selectionButton:
            guard let viewConverter = self.viewConverter.selectionButton.entireContent else { return false }
            let config = ViewConverter.SelectionButton.ViewConfig.init(
                user: user,
                isChecked: self.isChecked,
                operatorMode: self.operatorMode
            )
            guard let hostingView = viewConverter(config) else { return false }
            
            self.checkboxButton.removeFromSuperview()
            self.viewWithTag(tag)?.removeFromSuperview()
            
            hostingView.tag = tag
            self.baseStackView.addArrangedSubview(hostingView)
            
            hostingView.sbu_constraint(
                width: hostingView.intrinsicContentSize.width
            )
            
            hostingView.addGestureRecognizer(
                .init(target: self, action: #selector(self.onTapCheckBox(sender:)))
            )
            return true
        }
    }
}
