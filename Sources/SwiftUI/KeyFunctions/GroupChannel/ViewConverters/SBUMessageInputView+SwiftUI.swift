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
        get {
            SBViewConverterSet.GroupChannel.input.messageInputView
        }
        set {
            SBViewConverterSet.GroupChannel.input.messageInputView = newValue
        }
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
        alpha: CGFloat? = nil,
        quoteMessageInputViewParams: SBUQuoteMessageInputViewParams? = nil
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
                return true
            }
            return false
            
        // - Since: 1.1.0
        case .topView:
            Log.info("[.topView]  isFrozen=\(isFrozen), isMuted=\(isMuted), isQuoteReplyingMode=\(isQuoteReplyingMode), quoteMessageInputViewParams=\(String(describing: quoteMessageInputViewParams))")
            let config = ViewConverter.TopView.ViewConfig.init(
                isFrozen: self.isFrozen,
                isMuted: self.isMuted,
                isQuoteReplyingMode: self.isQuoteReplyingMode,
                quoteMessageInputViewConfiguration: QuoteMessageInputView.Configuration(
                    config: quoteMessageInputViewParams,
                    delegate: self
                ),
                quoteMessageInputViewHeight: DefaultViewConfigSet.GroupChannel.Input.quoteReplyInputViewHeight
            )
            
            if let viewConverter = self.viewConverter.topView.entireContent,
               let hostingView = viewConverter(config) {
                
                let viewUpdateData = ViewConverter.TopView.ViewUpdateData(
                    isHidden: isHidden,
                    isEnabled: isEnabled,
                    alpha: alpha,
                    quoteMessageInputViewParams: quoteMessageInputViewParams
                )
                self.viewConverter.topView.updateViewUpdateData(viewUpdateData)
                
                // setupViews
                self.topStackView.removeFromSuperview()
                
                let oldHostingView = self.contentVStackView.viewWithTag(tag)
                oldHostingView?.removeFromSuperview()
                
                hostingView.tag = tag
                self.contentVStackView.insertArrangedSubview(hostingView, at: 0)
                
                // setup layout
                
                // setup style
                
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
                // 고정 위치가 아니라 이웃 뷰 기준으로 넣는다 (음성 버튼 뷰 바로 앞).
                let index = self.sendButtonConverterIndex(voiceTag: RightViewConverter.ViewType.voiceButton.tag)
                self.inputHStackView.insertArrangedSubview(hostingView, at: index)
                
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
                // 고정 위치가 아니라 이웃 뷰 기준으로 넣는다 (전송 버튼 뷰 바로 뒤).
                let index = self.voiceButtonConverterIndex(sendTag: RightViewConverter.ViewType.sendButton.tag)
                self.inputHStackView.insertArrangedSubview(hostingView, at: index)
                
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

    // 전송, 음성 버튼 hosting view 를 넣을 자리.
    // 고정 위치(4, 5)로 넣으면 고객이 추가 버튼을 nil 로 둔 입력창에서 범위를 넘거나,
    // 전송 버튼만 다시 적용할 때(동결 상태 등) 음성 버튼 뒤로 밀린다.
    // 그래서 이웃 뷰 기준으로 넣는다. 이웃이 없을 때만 고정 위치를 스택 길이 안으로 줄여 쓴다.

    /// 전송 버튼 자리: 음성 버튼 뷰(UIKit 버튼 또는 음성 hosting view) 바로 앞.
    func sendButtonConverterIndex(voiceTag: Int?) -> Int {
        let views = self.inputHStackView.arrangedSubviews
        let voiceIndex = views.firstIndex { view in
            if let voiceButton = self.voiceMessageButton, view === voiceButton { return true }
            if let voiceTag, view.tag == voiceTag { return true }
            return false
        }
        return voiceIndex ?? min(4, views.count)
    }

    /// 음성 버튼 자리: 전송 버튼 뷰(UIKit 버튼 또는 전송 hosting view) 바로 뒤.
    func voiceButtonConverterIndex(sendTag: Int) -> Int {
        let views = self.inputHStackView.arrangedSubviews
        let sendIndex = views.firstIndex { view in
            if let sendButton = self.sendButton, view === sendButton { return true }
            return view.tag == sendTag
        }
        return sendIndex.map { $0 + 1 } ?? min(5, views.count)
    }
}
