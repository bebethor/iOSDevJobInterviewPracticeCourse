//
//  UIView+Extension.swift
//  GitHubFollowers
//
//  Created by Jose Alberto Ruíz-Carrillo González on 27/03/2020.
//  Copyright © 2020 JARCG. All rights reserved.
//

import UIKit


extension UIView {
    func addSubviews(_ views: UIView...) { // UIView... : Variadic parameter
        for view in views { addSubview(view) }
    }
    
    func pinToEdges(of superview: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
    }
}
