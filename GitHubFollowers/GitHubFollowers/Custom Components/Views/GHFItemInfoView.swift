//
//  GHFItemInfoView.swift
//  GitHubFollowers
//
//  Created by Jose Alberto Ruíz-Carrillo González on 06/03/2020.
//  Copyright © 2020 JARCG. All rights reserved.
//

import UIKit


class GHFItemInfoView: UIView {
    
    // MARK: - UI Elements -
    let symbolImageView     = UIImageView()
    let titleLabel          = GHFTitleLabel(textAlignment: .left, fontSize: 14)
    let countingReposLabel  = GHFTitleLabel(textAlignment: .center, fontSize: 14)
    
    // MARK: - Inits -
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        
    }
    
    
}
