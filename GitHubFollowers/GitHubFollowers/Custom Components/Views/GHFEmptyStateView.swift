//
//  GHFEmptyStateView.swift
//  GitHubFollowers
//
//  Created by Jose Alberto on 21/02/2020.
//  Copyright © 2020 JARCG. All rights reserved.
//

import UIKit

class GHFEmptyStateView: UIView {
    let messageLabel = GHFTitleLabel(textAlignment: .center, fontSize: 20)
    let imageView = GHFImageView(frame: .zero)
    
    // MARK: - Custom inits -
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Custom code here
    }
    // Story board init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
