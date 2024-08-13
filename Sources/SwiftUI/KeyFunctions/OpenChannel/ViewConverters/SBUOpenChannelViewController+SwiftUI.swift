//
//  SBUOpenChannelViewController+SwiftUI.swift
//  SendbirdSwiftUI
//
//  Created by Tez Park on 7/9/24.
//

import Foundation

// MARK: SwiftUIMessageInputInterface
extension SBUOpenChannelViewController: SwiftUIMessageInputInterface {
    func showFileActionSheet() {
        let items = SBUMessageInputView.generateResourceItems(channelType: .group)
        
        // show action sheet
        SBUActionSheet.show(
            items: items,
            cancelItem: SBUMessageInputView.cancelItem,
            oneTimetheme: nil,
            delegate: self
        )
        
        // handle the rest of cleanups to show the action sheet
        self.willPresentSubview()
    }
    
    func didTapResource(_ type: MediaResourceType) {
        self.didTapResource(of: type)
    }
}
