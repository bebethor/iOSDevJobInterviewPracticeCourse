//
//  GHFSecondaryTitleLabel.swift
//  GitHubFollowers
//
//  Created by Jose Alberto Ruíz-Carrillo González on 04/03/2020.
//  Copyright © 2020 JARCG. All rights reserved.
//

import UIKit

class GHFSecondaryTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        
    }
    
    // Custom initializer
    init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        configure()
    }
    
    private func configure() {
        textColor                                  = .label
        adjustsFontSizeToFitWidth                  = true
        minimumScaleFactor                         = 0.9
        lineBreakMode                              = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints  = false
    }
}
