//
//  GHFImageView.swift
//  GitHubFollowers
//
//  Created by Jose Alberto on 19/02/2020.
//  Copyright © 2020 JARCG. All rights reserved.
//

import UIKit

class GHFImageView: UIImageView {
    
    let placeHolderImage = UIImage(named: "avatar-placeholder")!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Custom code here
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius  = 10
        clipsToBounds       = true
        image               = placeHolderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
}
