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
    
    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }
    
    // MARK: - Configure -
    private func configure() {
        addSubviews(messageLabel, logoImageView)
        configureMessageLabel()
        configureLogoImageView()
    }
    
    // MARK: - UIElements -
    private func configureMessageLabel() {
        messageLabel.numberOfLines   = 3
        messageLabel.textColor       = .secondaryLabel
        
        //iphone SE and iphone 8 zoomed
        let messageLabelCenterYAnchorConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? -100 : -150
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: messageLabelCenterYAnchorConstant),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func configureLogoImageView() {
        logoImageView.image                                     = Images.emptyStateLogo
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        //iphone SE and iphone 8 zoomed
        let logoImageViewBottomConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 60: 40
        
        NSLayoutConstraint.activate([
            logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: logoImageViewBottomConstant),
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
        ])
    }
}
