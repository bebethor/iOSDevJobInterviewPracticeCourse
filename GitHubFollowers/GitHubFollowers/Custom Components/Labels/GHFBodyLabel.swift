//
//  GHFBodyLabel.swift
//  GitHubFollowers
//
//  Created by Jose Alberto on 17/02/2020.
//  Copyright © 2020 JARCG. All rights reserved.
//

import UIKit

class GHFBodyLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Custom code
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Custom initializer
    convenience init(textAligment: NSTextAlignment) {
        self.init(frame: .zero)
        self.textAlignment = textAligment
    }
    
    private func configure() {
        textColor                                  = .secondaryLabel
        font                                       = UIFont.preferredFont(forTextStyle: .body) // Dynamic font
        adjustsFontSizeToFitWidth                  = true
        minimumScaleFactor                         = 0.75
        lineBreakMode                              = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints  = false
    }
}
