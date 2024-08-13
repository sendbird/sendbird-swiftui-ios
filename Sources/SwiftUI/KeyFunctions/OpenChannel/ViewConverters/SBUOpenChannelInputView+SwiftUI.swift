//
//  SBUOpenChannelMessageInputView+SwiftUI.swift
//  SendbirdSwiftUI
//
//  Created by Tez Park on 7/8/24.
//

import UIKit
import SendbirdChatSDK

extension SBUMessageInputView {
    typealias ViewConverterForOpen = OpenChannelViewConverter.Input.MessageInputView
    var viewConverterForOpen: ViewConverterForOpen {
        SBViewConverterSet.OpenChannel.input.messageInputView
    }
    
    // MARK: - MessageInputView
    @discardableResult
    func applyViewConverterForOpen(
        _ viewType: ViewConverterForOpen.ViewType,
        isHidden: Bool? = nil,
        isEnabled: Bool? = nil,
        alpha: CGFloat? = nil
    ) -> Bool {
        let tag = viewType.tag
        
        switch viewType {
        case .leftView:
            let config = ViewConverterForOpen.LeftView.ViewConfig.init(
                isFrozen: self.isFrozen,
                isMuted: self.isMuted
            )
            
            if let viewConverter = self.viewConverterForOpen.leftView.entireContent,
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
            let config = ViewConverterForOpen.RightView.ViewConfig.init(
                isFrozen: self.isFrozen,
                isMuted: self.isMuted
            )
            
            if let viewConverter = self.viewConverterForOpen.rightView.entireContent,
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
    typealias LeftViewConverterForOpen = ViewConverterForOpen.LeftView
    var leftViewConverterForOpen: LeftViewConverterForOpen {
        viewConverterForOpen.leftView
    }
    
    @discardableResult
    func applyViewConverterForOpen(
        _ viewType: LeftViewConverterForOpen.ViewType,
        isHidden: Bool? = nil,
        isEnabled: Bool? = nil,
        alpha: CGFloat? = nil
    ) -> Bool {
        let tag = viewType.tag
        
        switch viewType {
        case .entireContent:
            return false
            
        case .addButton:
            let config = LeftViewConverterForOpen.AddButton.ViewConfig.init(
                isFrozen: self.isFrozen,
                isMuted: self.isMuted
            )
            
            if let viewConverter = self.leftViewConverterForOpen.addButton.entireContent,
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
    typealias RightViewConverterForOpen = ViewConverterForOpen.RightView
    var rightViewConverterForOpen: RightViewConverterForOpen {
        viewConverterForOpen.rightView
    }

    @discardableResult
    func applyViewConverterForOpen(
        _ viewType: RightViewConverterForOpen.ViewType,
        isHidden: Bool? = nil,
        isEnabled: Bool? = nil,
        alpha: CGFloat? = nil
    ) -> Bool {
        let tag = viewType.tag
        
        switch viewType {
        case .entireContent:
            return false
            
        case .sendButton:
            let config = RightViewConverterForOpen.SendButton.ViewConfig.init(
                isFrozen: self.isFrozen,
                isMuted: self.isMuted
            )
            
            if let viewConverter = self.rightViewConverterForOpen.sendButton.entireContent,
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
        }
    }
}
