//
//  SBUMessageThreadInputView+SwiftUI.swift
//  SendbirdSwiftUI
//
//  Created by Tez Park on 7/8/24.
//

import UIKit
import SendbirdChatSDK

extension SBUMessageInputView {
    typealias ViewConverterForThread = MessageThreadViewConverter.Input.MessageInputView
    var viewConverterForThread: ViewConverterForThread {
        SBViewConverterSet.MessageThread.input.messageInputView
    }
    
    // MARK: - MessageInputView
    @discardableResult
    func applyViewConverterForThread(
        _ viewType: ViewConverterForThread.ViewType,
        isHidden: Bool? = nil,
        isEnabled: Bool? = nil,
        alpha: CGFloat? = nil
    ) -> Bool {
        let tag = viewType.tag
        
        switch viewType {
        case .leftView:
            let config = ViewConverterForThread.LeftView.ViewConfig.init(
                isFrozen: self.isFrozen,
                isMuted: self.isMuted
            )
            
            if let viewConverter = self.viewConverterForThread.leftView.entireContent,
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
            let config = ViewConverterForThread.RightView.ViewConfig.init(
                isFrozen: self.isFrozen,
                isMuted: self.isMuted
            )
            
            if let viewConverter = self.viewConverterForThread.rightView.entireContent,
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
    typealias LeftViewConverterForThread = ViewConverterForThread.LeftView
    var leftViewConverterForThread: LeftViewConverterForThread {
        viewConverterForThread.leftView
    }
    
    @discardableResult
    func applyViewConverterForThread(
        _ viewType: LeftViewConverterForThread.ViewType,
        isHidden: Bool? = nil,
        isEnabled: Bool? = nil,
        alpha: CGFloat? = nil
    ) -> Bool {
        let tag = viewType.tag
        
        switch viewType {
        case .entireContent:
            return false
            
        case .addButton:
            let config = LeftViewConverterForThread.AddButton.ViewConfig.init(
                isFrozen: self.isFrozen,
                isMuted: self.isMuted
            )
            
            if let viewConverter = self.leftViewConverterForThread.addButton.entireContent,
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
    typealias RightViewConverterForThread = ViewConverterForThread.RightView
    var rightViewConverterForThread: RightViewConverterForThread {
        viewConverterForThread.rightView
    }
    
    @discardableResult
    func applyViewConverterForThread(
        _ viewType: RightViewConverterForThread.ViewType,
        isHidden: Bool? = nil,
        isEnabled: Bool? = nil,
        alpha: CGFloat? = nil
    ) -> Bool {
        let tag = viewType.tag
        
        switch viewType {
        case .entireContent:
            return false
            
        case .sendButton:
            let config = RightViewConverterForThread.SendButton.ViewConfig.init(
                isFrozen: self.isFrozen,
                isMuted: self.isMuted
            )
            
            if let viewConverter = self.rightViewConverterForThread.sendButton.entireContent,
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
            let config = RightViewConverterForThread.VoiceButton.ViewConfig.init(
                isFrozen: self.isFrozen,
                isMuted: self.isMuted
            )
            
            if let viewConverter = self.rightViewConverterForThread.voiceButton.entireContent,
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
}
