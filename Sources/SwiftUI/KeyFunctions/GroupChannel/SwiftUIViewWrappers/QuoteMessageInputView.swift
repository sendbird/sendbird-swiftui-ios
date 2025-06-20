//
//  QuoteMessageInputView.swift
//  SendbirdSwiftUI
//
//  Created by Celine Moon on 5/16/25.
//

import SwiftUI
import SendbirdChatSDK

/// View that shows information about the parent message when replying in ``SBUReplyType.quoteReply`` mode.
/// - Parameter configuration: the configuration needed to initialize `QuoteMessageInputView`
/// - Since: 1.1.0
public struct QuoteMessageInputView: SendbirdView {
    typealias SBUViewType = SBUQuoteMessageInputView
    
    public var configuration: QuoteMessageInputView.Configuration
    
    public var body: some View {
        SBUQuoteMessageInputView
            .swiftUI {
                createUIView()
            }
    }
    
    func createUIView() -> SBUQuoteMessageInputView {
        let quoteView = SBUQuoteMessageInputView()
        if let config = configuration.config,
           let delegate = configuration.delegate {
            quoteView.configure(with: config)
            quoteView.delegate = delegate
        }
        return quoteView
    }
}

extension QuoteMessageInputView {
    /// Configurations used to configure ``QuoteMessageInputView``.
    /// - Since: 1.1.0
    public struct Configuration {
        var config: SBUQuoteMessageInputViewParams?
        var delegate: SBUQuoteMessageInputViewDelegate?
    }
}
