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
        configureMessageLabel()
        configureLogoImageView()
    }
    
    private func configureMessageLabel() {
        addSubview(messageLabel)
        messageLabel.numberOfLines   = 3
        messageLabel.textColor       = .secondaryLabel
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func configureLogoImageView() {
        addSubview(logoImageView)
        logoImageView.image                                     = UIImage(named: "empty-state-logo")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
    }
}
