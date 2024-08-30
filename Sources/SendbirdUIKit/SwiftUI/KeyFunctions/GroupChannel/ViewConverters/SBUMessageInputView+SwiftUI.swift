//
//  SBUMessageInputView+SwiftUI.swift
//  SendbirdUIKit
//
//  Created by Celine Moon on 7/5/24.
//

import UIKit
import SendbirdChatSDK

extension SBUMessageInputView {
    typealias ViewConverter = GroupChannelViewConverter.Input.MessageInputView
    var viewConverter: ViewConverter {
        SBViewConverterSet.GroupChannel.input.messageInputView
    }
    
    typealias LeftViewConverter = ViewConverter.LeftView
    var leftViewConverter: LeftViewConverter {
        viewConverter.leftView
    }
    
    typealias RightViewConverter = ViewConverter.RightView
    var rightViewConverter: RightViewConverter {
        viewConverter.rightView
    }
    
    // MARK: - MessageInputView
    @discardableResult
    func applyViewConverter(
        _ viewType: ViewConverter.ViewType,
        isHidden: Bool? = nil,
        isEnabled: Bool? = nil,
        alpha: CGFloat? = nil
    ) -> Bool {
        let tag = viewType.tag
        
        switch viewType {
        case .leftView:
            let config = ViewConverter.LeftView.ViewConfig.init(
                isFrozen: self.isFrozen,
                isMuted: self.isMuted
            )
            
            if let viewConverter = self.viewConverter.leftView.entireContent,
               let hostingView = viewConverter(config) {
                // setupViews
                self.addButton?.removeFromSuperview()
                
                let oldHostingView = self.inputHStackView.viewWithTag(tag)
                oldHostingView?.removeFromSuperview()

                hostingView.tag = tag
                self.inputHStackView.insertArrangedSubview(hostingView, at: 0)
                
                // setupLayout
                
                // setupActions
                
                // setup state
                updateState(
                    for: hostingView,
                    isHidden: isHidden ?? oldHostingView?.isHidden,
                    isEnabled: isEnabled ?? oldHostingView?.isUserInteractionEnabled,
                    alpha: alpha ?? oldHostingView?.alpha
                )
                
                return true
            }
            return false
            
        case .rightView:
            let config = ViewConverter.RightView.ViewConfig.init(
                isFrozen: self.isFrozen,
                isMuted: self.isMuted
            )
            
            if let viewConverter = self.viewConverter.rightView.entireContent,
               let hostingView = viewConverter(config) {
                
                // setupViews
                self.sendButton?.removeFromSuperview()
                self.voiceMessageButton?.removeFromSuperview()
                
                let oldHostingView = self.inputHStackView.viewWithTag(tag)
                oldHostingView?.removeFromSuperview()
                
                hostingView.tag = tag
                self.inputHStackView.insertArrangedSubview(hostingView, at: inputHStackView.arrangedSubviews.count)
                
                // setupLayouts
                
                // setupActions
                
                // setup state
                updateState(
                    for: hostingView,
                    isHidden: isHidden ?? oldHostingView?.isHidden,
                    isEnabled: isEnabled ?? oldHostingView?.isUserInteractionEnabled,
                    alpha: alpha ?? oldHostingView?.alpha
                )
            }
            return false
        }
    }
    
    // MARK: - LeftView
    @discardableResult
    func applyViewConverter(
        _ viewType: LeftViewConverter.ViewType,
        isHidden: Bool? = nil,
        isEnabled: Bool? = nil,
        alpha: CGFloat? = nil
    ) -> Bool {
        let tag = viewType.tag
        
        switch viewType {
        case .entireContent:
            return false
            
        case .addButton:
            let config = LeftViewConverter.AddButton.ViewConfig.init(
                isFrozen: self.isFrozen,
                isMuted: self.isMuted
            )
            
            if let viewConverter = self.leftViewConverter.addButton.entireContent,
               let hostingView = viewConverter(config) {
                // setupViews
                self.addButton?.removeFromSuperview()
                
                let oldHostingView = self.inputHStackView.viewWithTag(tag)
                oldHostingView?.removeFromSuperview()
                
                hostingView.tag = tag    
                self.inputHStackView.insertArrangedSubview(hostingView, at: 0)
                
                // setupLayout
                
                // setupActions
                let tapRecognizer = UITapGestureRecognizer(
                    target: self,
                    action: #selector(self.onTapAddButton(_:))
                )
                hostingView.addGestureRecognizer(tapRecognizer)
                
                // setup state
                updateState(
                    for: hostingView,
                    isHidden: isHidden ?? oldHostingView?.isHidden,
                    isEnabled: isEnabled ?? oldHostingView?.isUserInteractionEnabled,
                    alpha: alpha ?? oldHostingView?.alpha
                )
            }
            return true

        }
    }
    
    // MARK: - RightView
    @discardableResult
    func applyViewConverter(
        _ viewType: RightViewConverter.ViewType,
        isHidden: Bool? = nil,
        isEnabled: Bool? = nil,
        alpha: CGFloat? = nil
    ) -> Bool {
        let tag = viewType.tag
        
        switch viewType {
        case .entireContent:
            return false
            
        case .sendButton:
            let config = RightViewConverter.SendButton.ViewConfig.init(
                isFrozen: self.isFrozen,
                isMuted: self.isMuted
            )
            
            if let viewConverter = self.rightViewConverter.sendButton.entireContent,
               let hostingView = viewConverter(config) {
                // setupViews
                self.sendButton?.removeFromSuperview()
                
                let oldHostingView = self.inputHStackView.viewWithTag(tag)
                oldHostingView?.removeFromSuperview()
                
                hostingView.tag = tag    
                self.inputHStackView.insertArrangedSubview(hostingView, at: 4)
                
                // setupLayout
                
                // setupActions
                let tapRecognizer = UITapGestureRecognizer(
                    target: self,
                    action: #selector(self.onTapSendButton(_:))
                )
                hostingView.addGestureRecognizer(tapRecognizer)
                
                // setup state
                updateState(
                    for: hostingView,
                    isHidden: isHidden ?? oldHostingView?.isHidden,
                    isEnabled: isEnabled ?? oldHostingView?.isUserInteractionEnabled,
                    alpha: alpha ?? oldHostingView?.alpha
                )
            }
            return true
        
        case .voiceButton:
            let config = RightViewConverter.VoiceButton.ViewConfig.init(
                isFrozen: self.isFrozen,
                isMuted: self.isMuted
            )
            
            if let viewConverter = self.rightViewConverter.voiceButton.entireContent,
               let hostingView = viewConverter(config) {
                // setupViews
                self.voiceMessageButton?.removeFromSuperview()
                
                let oldHostingView = self.inputHStackView.viewWithTag(tag)
                oldHostingView?.removeFromSuperview()
                
                hostingView.tag = tag    
                self.inputHStackView.insertArrangedSubview(hostingView, at: 5)
                
                // setupLayout
                
                // setupActions
                let tapRecognizer = UITapGestureRecognizer(
                    target: self,
                    action: #selector(self.onTapVoiceMessageButton(_:))
                )
                hostingView.addGestureRecognizer(tapRecognizer)
                
                // setup state
                updateState(
                    for: hostingView,
                    isHidden: isHidden ?? oldHostingView?.isHidden,
                    isEnabled: isEnabled ?? oldHostingView?.isUserInteractionEnabled,
                    alpha: alpha ?? oldHostingView?.alpha
                )
            }
            return true
        }
    }
    
    // MARK: - Common
    /// Updates the channel state data for the hostingView.
    func updateState(
        for hostingView: UIView,
        isHidden: Bool? = nil,
        isEnabled: Bool? = nil,
        alpha: CGFloat? = nil
    ) {
        if let isHidden {
            hostingView.isHidden = isHidden
        }
        
        if let isEnabled {
            hostingView.isUserInteractionEnabled = isEnabled
        }
        
        if let alpha {
            hostingView.alpha = alpha
        }
    }
}
