//
//  GHFTextField.swift
//  GitHubFollowers
//
//  Created by Jose Alberto Ruíz-Carrillo González on 10/02/2020.
//  Copyright © 2020 JARCG. All rights reserved.
//

import UIKit

class GHFTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        // Custom code here
        configure()
    }
    
    // Story board initializer
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius         = 10
        layer.borderWidth          = 2
        layer.borderColor          = UIColor.systemGray4.cgColor
        
        textColor                  = .label
        tintColor                  = .label
        textAlignment              = .center
        font                       = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth  = true
        minimumFontSize            = 12
        
        backgroundColor            = .tertiarySystemBackground
        autocorrectionType         = .no
        clearButtonMode            = .whileEditing
        returnKeyType              = .go
        placeholder                = "Enter user name"
    }
}
