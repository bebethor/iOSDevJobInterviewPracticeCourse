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
    
    init(message: String) {
        super.init(frame: .zero)
        messageLabel.text = message
        configure()
    }
    
    // MARK: - Configure -
    private func configure() {
        configureMessageLabel()
        configureLogoImageView()
    }
    
    // MARK: - UIElements -
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
        
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
            logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 40)
        ])
    }
}
