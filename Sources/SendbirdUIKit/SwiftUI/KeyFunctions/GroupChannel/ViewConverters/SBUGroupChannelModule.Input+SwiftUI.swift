//
//  SBUGroupChannelModule.Input+SwiftUI.swift
//  SendbirdSwiftUI
//
//  Created by Celine Moon on 7/5/24.
//

import UIKit
import SendbirdChatSDK

extension SBUGroupChannelModule.Input {
    typealias ViewConverter = GroupChannelViewConverter.Input
    var viewConverter: ViewConverter {
        SBViewConverterSet.GroupChannel.input
    }
}

extension SBUGroupChannelModule.Input {
    @discardableResult
    func applyViewConverter(_ viewType: ViewConverter.ViewType) -> Bool {
        let tag = viewType.tag
        
        switch viewType {
        case .entireContent:
            // NOTE: Input.configure() -> setupViews() 시점은 channel 로딩이 아직 완료 안된 시점임.
            guard let viewController = self.delegate as? SBUGroupChannelViewController
            else { return false }
            
            let config = ViewConverter.ViewConfig.init(
                parentView: viewController
            )
            
            if let viewConverter = self.viewConverter.entireContent,
                let hostingView = viewConverter(config) {
                // setupView
                DispatchQueue.main.async {
                    self.inputVStackView.removeAllSubviews()
                    self.viewWithTag(tag)?.removeFromSuperview()
                    
                    hostingView.tag = tag
                    self.addSubview(hostingView)
                    
                    // setupLayout
                    hostingView
                        .sbu_constraint_fill(equalTo: self)
                        .sbu_constraint(width: self.frame.width)
                    
                    // setupActions
                }
                return true
            }
        }
        return false
    }
}
