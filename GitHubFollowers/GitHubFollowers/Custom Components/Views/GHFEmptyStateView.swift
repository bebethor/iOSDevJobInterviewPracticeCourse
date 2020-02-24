//
//  GHFEmptyStateView.swift
//  GitHubFollowers
//
//  Created by Jose Alberto on 21/02/2020.
//  Copyright © 2020 JARCG. All rights reserved.
//

import UIKit

class GHFEmptyStateView: UIView {
    let messageLabel = GHFTitleLabel(textAlignment: .center, fontSize: 28)
    let logoImageView = UIImageView()
    
    // MARK: - Custom inits -
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Custom code here
        configure()
    }
    // Story board init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(messageLabel)
        addSubview(logoImageView)
    }
    
    private func configureMessageLabel() {
        messageLabel.numberOfLines   = 3
        messageLabel.textColor       = .secondaryLabel
    }
    
    private func configureLogoImageView() {
        logoImageView.image                                     = UIImage(named: "empty-state-logo")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
    }
}
