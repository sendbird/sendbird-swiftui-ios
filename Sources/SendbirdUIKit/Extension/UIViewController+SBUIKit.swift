//
//  UIViewController+SBUIKit.swift
//  SendbirdUIKit
//
//  Created by Tez Park on 03/02/2020.
//  Copyright © 2020 Sendbird, Inc. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    // Not using now
    func sbu_loadViewFromNib() {
        #if PROCESS_RESOURCE
        let bundle = Bundle.module
        let nib = bundle.loadNibNamed(
            String(describing: type(of: self)),
            owner: self,
            options: nil
        )
        #else
        let bundle = Bundle(identifier: SBUConstant.bundleIdentifier)
        let nib = bundle?.loadNibNamed(
            String(describing: type(of: self)),
            owner: self,
            options: nil
        )
        #endif
        guard let view = nib?.first as? UIView else { return }
        
        view.frame = self.view.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.insertSubview(view, at: 0)
    }
}
