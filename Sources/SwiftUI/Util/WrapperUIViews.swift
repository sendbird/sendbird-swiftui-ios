//
//  WrapperUIViews.swift
//  SendbirdUIKit
//
//  Created by Celine Moon on 6/24/24.
//

import UIKit
import SwiftUI

#if SWIFTUI
// MARK: Wrapper View Classes
class SwiftUIContainerView: SBUView {
    var subview: UIView?  // hostingController.view
    
    init(subview: UIView) {
        self.subview = subview
        super.init()
    }
    
    override func setupViews() {
        if let subview = subview {
            self.addSubview(subview)
        }
    }
    
    open override func setupLayouts() {
        super.setupLayouts()
        self.subview?.sbu_constraint(equalTo: self, left: 0, right: 0, top: 0, bottom: 0)
    }
}

class SwiftUIBarButtonItem: UIBarButtonItem {
    init(subview: UIView, target: Any? = nil, action: Selector? = nil) {
        super.init()
        
        let containerView = UIView()
        containerView.addSubview(subview)
        subview.sbu_constraint_fill(equalTo: containerView)
        containerView.sbu_constraint(
            width: subview.intrinsicContentSize.width,
            height: subview.intrinsicContentSize.height
        )
      
        if let target, let action {
            // NOTE: if we use customView, target and action don't work on UIBarButtonItem, so we need to use gesture recognizer.
            let tapRecognizer = UITapGestureRecognizer(target: target, action: action)
            subview.addGestureRecognizer(tapRecognizer)
        }
        
        self.customView = containerView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
#endif
