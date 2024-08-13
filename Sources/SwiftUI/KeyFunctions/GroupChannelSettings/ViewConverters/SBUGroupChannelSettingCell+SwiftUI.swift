//
//  File.swift
//  SendbirdUIKit
//
//  Created by Kai Lee on 7/8/24.
//

import SendbirdChatSDK

extension SBUGroupChannelSettingCell {
    typealias SettingCellViewConverter = GroupChannelSettingsViewConverter.List.TableView.SettingCell
    
    var settingCellViewConverter: SettingCellViewConverter {
        SBViewConverterSet.GroupChannelSettings.list.tableView.settingCell
    }
    
    func applyViewConverter(
        _ viewType: SettingCellViewConverter.ViewType,
        item channelSettingItem: SBUChannelSettingItem,
        channel: GroupChannel? = nil
    ) -> Bool {
        let tag = viewType.tag
        
        func processView<T>(_ config: T, viewConverter: ViewConverter<T>?) -> Bool {
            // To prepare for reuse, all subviews' visibility always need to be restored
            restoreSubviewsVisibility(by: channelSettingItem)
            
            // Remove all subviews other than `baseStackView`.
            // `baseStackView` must be alive. Otherwise, it breaks whole view layout when a cell is reused.
            self.contentView.subviews
                .filter { $0 != self.baseStackView && $0 != self.separateView }
                .forEach { $0.removeFromSuperview() }

            guard let viewConverter, let hostingView = viewConverter(config) else {
                return false
            }
            
            // Hide all subviews instead of removing them.
            // It's for reuse.
            self.baseStackView.subviews.forEach { $0.isHidden = true }
            
            self.contentView.addSubview(hostingView)
            hostingView.sbu_constraint_fill(equalTo: contentView)
            
            return true
        }
        
        switch viewType {
        case .entireContent:
            if let cellConverter = self.settingCellViewConverter.entireContent,
               let hostingView = cellConverter(.init()) {
                
                self.baseStackView.removeFromSuperview()
                self.contentView.viewWithTag(tag)?.removeFromSuperview()
                
                hostingView.tag = tag
                self.contentView.addSubview(hostingView)
                
                hostingView.sbu_constraint(width: hostingView.intrinsicContentSize.width, height: hostingView.intrinsicContentSize.height)
                hostingView.sbu_constraint_fill(equalTo: contentView)
                
                return true
            }
            
        case .moderation:
            let config = SettingCellViewConverter.Moderation.ViewConfig(
                title: channelSettingItem.title
            )
            return processView(config, viewConverter: self.settingCellViewConverter.moderation.entireContent)
            
        case .notification:
            guard let channel else { return false }
            
            let config = SettingCellViewConverter.Notification.ViewConfig(
                title: channelSettingItem.title,
                pushTriggerOption: channel.myPushTriggerOption
            )
            return processView(config, viewConverter: self.settingCellViewConverter.notification.entireContent)
            
        case .member:
            guard let channel else { return false }

            let config = SettingCellViewConverter.Member.ViewConfig(
                title: channelSettingItem.title,
                memberCount: Int(channel.memberCount)
            )
            return processView(config, viewConverter: self.settingCellViewConverter.member.entireContent)
            
        case .searchItem:
            let config = SettingCellViewConverter.SearchItem.ViewConfig(
                title: channelSettingItem.title
            )
            return processView(config, viewConverter: self.settingCellViewConverter.searchItem.entireContent)
            
        case .leaveChannel:
            let config = SettingCellViewConverter.LeaveChannel.ViewConfig(
                title: channelSettingItem.title
            )
            return processView(config, viewConverter: self.settingCellViewConverter.leaveChannel.entireContent)
        }
        
        return false
    }
    
    private func restoreSubviewsVisibility(by item: SBUChannelSettingItem) {
        typeIcon.isHidden = false
        titleLabel.isHidden = false
        subTitleLabel.isHidden = false
        subTitleLabel.isHidden = (item.subTitle == nil)
        rightButton.isHidden = item.isRightButtonHidden
        if item.isRightButtonHidden {
            rightSwitch.isHidden = item.isRightSwitchHidden
        }
    }
}
