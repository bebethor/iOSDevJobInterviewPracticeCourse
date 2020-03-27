//
//  UIView+Extension.swift
//  GitHubFollowers
//
//  Created by Jose Alberto Ruíz-Carrillo González on 27/03/2020.
//  Copyright © 2020 JARCG. All rights reserved.
//

import UIKit


extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
}
