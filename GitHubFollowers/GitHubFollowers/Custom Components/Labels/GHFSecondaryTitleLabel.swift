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

    // Custom initializer
    convenience init(fontSize: CGFloat) {
        self.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }
    
    private func configure() {
        textColor                                  = .secondaryLabel
        adjustsFontSizeToFitWidth                  = true
        minimumScaleFactor                         = 0.9
        lineBreakMode                              = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints  = false
    }
}
