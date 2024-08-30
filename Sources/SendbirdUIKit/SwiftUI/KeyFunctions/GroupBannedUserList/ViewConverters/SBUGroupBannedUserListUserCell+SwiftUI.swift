//
//  SBUGroupBannedUserListUserCell+SwiftUI.swift
//  SendbirdSwiftUI
//
//  Created by Tez Park on 7/19/24.
//

import Foundation
import UIKit

extension SBUUserCell {
    typealias ViewConverterForBannedUser = GroupBannedUserListViewConverter.List.TableView.RowView
    var viewConverterForBannedUser: ViewConverterForBannedUser {
        SBViewConverterSet.GroupBannedUserList.list.tableView.rowView
    }
    
    @discardableResult
    func applyViewConverterForBannedUser(_ viewType: ViewConverterForBannedUser.ViewType) -> Bool {
        let tag = viewType.tag
        guard let user = self.user else { return false }
        
        switch viewType {
        case .entireContent:
            guard let viewConverter = self.viewConverterForBannedUser.entireContent else { return false }
            let config = ViewConverterForBannedUser.ViewConfig.init(
                user: user,
                isOperator: user.isOperator
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
            guard let viewConverter = self.viewConverterForBannedUser.profileImage.entireContent else { return false }
            let config = ViewConverterForBannedUser.ProfileImage.ViewConfig.init(
                user: user,
                isOperator: user.isOperator,
                profileURL: user.profileURL ?? ""
            )
            guard let hostingView = viewConverter(config) else { return false }
            
            self.userImageView.removeFromSuperview()
            self.viewWithTag(tag)?.removeFromSuperview()
            
            hostingView.tag = tag
            self.baseStackView.insertArrangedSubview(hostingView, at: 0)
            
            hostingView.sbu_constraint(
                width: hostingView.intrinsicContentSize.width
            )

            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.onTapUserProfileView(sender:)))
            tapGesture.cancelsTouchesInView = false
            hostingView.addGestureRecognizer(tapGesture)

            return true
        case .userNameLabel:
            guard let viewConverter = self.viewConverterForBannedUser.userNameLabel.entireContent else { return false }
            let config = ViewConverterForBannedUser.UserNameLabel.ViewConfig.init(
                user: user,
                nickname: user.refinedNickname(),
                isOperator: user.isOperator
            )
            guard let hostingView = viewConverter(config) else { return false }
            
            self.nicknameLabel.removeFromSuperview()
            self.viewWithTag(tag)?.removeFromSuperview()
            
            hostingView.tag = tag
            self.baseStackView.insertArrangedSubview(hostingView, at: 1)
            
            hostingView.setContentHuggingPriority(.required, for: .horizontal)
            
            return true
        
        case .moreButton:
            guard let viewConverter = self.viewConverterForBannedUser.moreButton.entireContent else { return false }
            let config = ViewConverterForBannedUser.MoreButton.ViewConfig.init(
                user: user,
                isOperatorMode: self.operatorMode
            )
            guard let hostingView = viewConverter(config) else { return false }
            
            self.moreButton.removeFromSuperview()
            self.viewWithTag(tag)?.removeFromSuperview()
            
            hostingView.tag = tag
            if self.baseStackView.arrangedSubviews.count > 5 {
                self.baseStackView.insertArrangedSubview(hostingView, at: 4)
            } else {
                self.baseStackView.addArrangedSubview(hostingView)
            }
            
            hostingView.sbu_constraint(
                width: hostingView.intrinsicContentSize.width
            )
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.onClickMoreMenu))
            tapGesture.cancelsTouchesInView = false
            hostingView.addGestureRecognizer(tapGesture)

            return true
        }
    }
}
