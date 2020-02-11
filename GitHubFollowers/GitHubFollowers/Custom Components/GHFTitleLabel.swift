//
//  GHFTitleLabel.swift
//  GitHubFollowers
//
//  Created by Jose Alberto Ruíz-Carrillo González on 11/02/2020.
//  Copyright © 2020 JARCG. All rights reserved.
//

import UIKit

class GHFTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Custom code
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Custom initializer
    init(textAligment: NSTextAlignment, fontSize: CGFloat) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }
    
    private func configure() {
        textColor                                  = .label
        adjustsFontSizeToFitWidth                  = true
        minimumScaleFactor                         = 0.90
        lineBreakMode                              = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints  = false
    }
}