//
//  SBUInviteUserCell+SwiftUI.swift
//  SendbirdSwiftUI
//
//  Created by Tez Park on 7/8/24.
//

import Foundation
import UIKit

extension SBUUserCell {
    typealias ViewConverterForInvite = InviteUserViewConverter.List.TableView.RowView
    var viewConverterForInvite: ViewConverterForInvite {
        SBViewConverterSet.InviteUser.list.tableView.rowView
    }
    
    @discardableResult
    func applyViewConverterForInvite(_ viewType: ViewConverterForInvite.ViewType) -> Bool {
        let tag = viewType.tag
        guard let user = self.user else { return false }
        
        switch viewType {
        case .entireContent:
            guard let viewConverter = self.viewConverterForInvite.entireContent else { return false }
            let config = ViewConverterForInvite.ViewConfig.init(
                user: user,
                isChecked: self.isChecked
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
            guard let viewConverter = self.viewConverterForInvite.profileImage.entireContent else { return false }
            let config = ViewConverterForInvite.ProfileImage.ViewConfig.init(
                user: user,
                profileURL: user.profileURL ?? "",
                isChecked: self.isChecked
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
            guard let viewConverter = self.viewConverterForInvite.userNameLabel.entireContent else { return false }
            let config = ViewConverterForInvite.UserNameLabel.ViewConfig.init(
                user: user,
                nickname: user.refinedNickname(),
                isChecked: self.isChecked
            )
            guard let hostingView = viewConverter(config) else { return false }
            
            self.nicknameLabel.removeFromSuperview()
            self.viewWithTag(tag)?.removeFromSuperview()
            
            hostingView.tag = tag
            self.baseStackView.insertArrangedSubview(hostingView, at: 1)
            
            hostingView.setContentHuggingPriority(.required, for: .horizontal)
            
            return true
        case .selectionButton:
            guard let viewConverter = self.viewConverterForInvite.selectionButton.entireContent else { return false }
            let config = ViewConverterForInvite.SelectionButton.ViewConfig.init(
                user: user,
                isChecked: self.isChecked
            )
            guard let hostingView = viewConverter(config) else { return false }
            
            self.checkboxButton.removeFromSuperview()
            self.viewWithTag(tag)?.removeFromSuperview()
            
            hostingView.tag = tag
            self.baseStackView.addArrangedSubview(hostingView)
            
            hostingView.sbu_constraint(
                width: hostingView.intrinsicContentSize.width
            )
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.onTapCheckBox(sender:)))
            tapGesture.cancelsTouchesInView = false
            hostingView.addGestureRecognizer(tapGesture)

            return true
        }
    }
}
