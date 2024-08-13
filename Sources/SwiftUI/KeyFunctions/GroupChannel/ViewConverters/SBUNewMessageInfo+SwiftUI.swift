//
//  SBUNewMessageInfo+SwiftUI.swift
//  SendbirdSwiftUI
//
//  Created by Celine Moon on 7/4/24.
//

import UIKit
import SendbirdChatSDK

extension SBUNewMessageInfo {
    typealias ViewConverter = GroupChannelViewConverter.List.NewMessageInfoView
    var viewConverter: ViewConverter {
        SBViewConverterSet.GroupChannel.list.newMessageInfoView
    }
    
    @discardableResult
    func applyViewConverter(_ viewType: ViewConverter.ViewType, count: Int? = nil) -> Bool {
        let tag = viewType.tag
        
        self.count = count ?? self.count
        
        switch viewType {
        case .entireContent:
            let config = ViewConverter.ViewConfig.init(count: self.count)
            
            if let entireViewConverter = self.viewConverter.entireContent,
               let hostingView = entireViewConverter(config) {
                // setupView
                self.messageInfoButton?.removeFromSuperview()
                self.viewWithTag(tag)?.removeFromSuperview()

                hostingView.tag = tag
                self.addSubview(hostingView)
                
                // setupLayout
                hostingView.sbu_constraint_fill(equalTo: self)
                
                // setupAction
                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onClickNewMessageInfo))
                hostingView.addGestureRecognizer(tapGestureRecognizer)
                return true
            }
        }
        return false 
    }
}
