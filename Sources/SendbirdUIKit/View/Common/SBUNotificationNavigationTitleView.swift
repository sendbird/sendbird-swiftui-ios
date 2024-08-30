//
//  SBUNotificationNavigationTitleView.swift
//  QuickStart
//
//  Created by Tez Park on 2023/03/12.
//  Copyright © 2023 SendBird, Inc. All rights reserved.
//

import UIKit

class SBUNotificationNavigationTitleView: SBUView {
    var theme: SBUNotificationTheme.Header {
        switch SBUTheme.colorScheme {
        case .light: return .light
        case .dark: return .dark
        }
    }
    
    var text: String? = ""
    var textAlignment: NSTextAlignment = .center
    
    var titleLabel = UILabel()
     
    override init() {
        super.init()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable, renamed: "SBUNotificationNavigationTitleView.init(frame:)")
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func setupViews() {
        self.titleLabel.textAlignment = self.textAlignment

        self.addSubview(self.titleLabel)
    }
    
    override func setupLayouts() {
        super.setupLayouts()
        
        self.titleLabel.sbu_constraint(equalTo: self, left: 0, right: 0, top: 0, bottom: 0)
    }
    
    override func setupStyles() {
        super.setupStyles()
        
        self.backgroundColor = .clear
        
        self.titleLabel.font = theme.textFont
        self.titleLabel.textColor = theme.textColor
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.titleLabel.frame = self.bounds
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.titleLabel.text = self.text
        
        self.setupStyles()
    }
    
    func configure(title: String?) {
        if let title = title {
            self.text = title
            self.titleLabel.text = title
        }
    }
}
