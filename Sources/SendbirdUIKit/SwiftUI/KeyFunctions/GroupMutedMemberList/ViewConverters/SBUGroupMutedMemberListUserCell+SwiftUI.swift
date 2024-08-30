//
//  SBUGroupMutedMemberListUserCell+SwiftUI.swift
//  SendbirdSwiftUI
//
//  Created by Tez Park on 7/19/24.
//

import Foundation
import UIKit

extension SBUUserCell {
    typealias ViewConverterForMutedMember = GroupMutedMemberListViewConverter.List.TableView.RowView
    var viewConverterForMutedMember: ViewConverterForMutedMember {
        SBViewConverterSet.GroupMutedMemberList.list.tableView.rowView
    }
    
    @discardableResult
    func applyViewConverterForMutedMember(_ viewType: ViewConverterForMutedMember.ViewType) -> Bool {
        let tag = viewType.tag
        guard let user = self.user else { return false }
        
        switch viewType {
        case .entireContent:
            guard let viewConverter = self.viewConverterForMutedMember.entireContent else { return false }
            let config = ViewConverterForMutedMember.ViewConfig.init(
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
            guard let viewConverter = self.viewConverterForMutedMember.profileImage.entireContent else { return false }
            let config = ViewConverterForMutedMember.ProfileImage.ViewConfig.init(
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
            guard let viewConverter = self.viewConverterForMutedMember.userNameLabel.entireContent else { return false }
            let config = ViewConverterForMutedMember.UserNameLabel.ViewConfig.init(
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
        
        case .operatorStateView:
            guard let viewConverter = self.viewConverterForMutedMember.operatorStateView.entireContent else { return false }
            let config = ViewConverterForMutedMember.OperatorStateView.ViewConfig.init(
                user: user,
                isOperator: user.isOperator
            )
            guard let hostingView = viewConverter(config) else { return false }

            self.operatorLabel.removeFromSuperview()
            self.viewWithTag(tag)?.removeFromSuperview()
            
            hostingView.tag = tag
            if self.baseStackView.arrangedSubviews.count > 4 {
                self.baseStackView.insertArrangedSubview(hostingView, at: 3)
            } else {
                self.baseStackView.addArrangedSubview(hostingView)
            }
            
            hostingView.sbu_constraint(
                width: hostingView.intrinsicContentSize.width
            )
            return true
            
        case .moreButton:
            guard let viewConverter = self.viewConverterForMutedMember.moreButton.entireContent else { return false }
            let config = ViewConverterForMutedMember.MoreButton.ViewConfig.init(
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
