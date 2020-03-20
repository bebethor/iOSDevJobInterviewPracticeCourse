//
//  GHFCollectionViewCell.swift
//  GitHubFollowers
//
//  Created by Jose Alberto on 19/02/2020.
//  Copyright © 2020 JARCG. All rights reserved.
//

import UIKit

class GHFCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Elements -
    static let reuseID   = "FollowerCell"
    let avatarImageView  = GHFImageView(frame: .zero)
    let userNameLabel    = GHFTitleLabel(textAlignment: .center, fontSize: 16)
    
    // MARK: - Properties -
    let padding: CGFloat = 8
    
    
    // MARK: - Inits -
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Custom code here
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Configure UI functions -
    func set(follower: Follower) {
        userNameLabel.text = follower.login
        avatarImageView.downLoadImage(from: follower.avatarUrl)
    }
    
    private func configure() {
        configureAvatarImageView()
        configureUserNameLabel()
    }
    
    private func configureAvatarImageView() {
        addSubview(avatarImageView)
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor)
        ])
    }
    
    private func configureUserNameLabel() {
        addSubview(userNameLabel)
        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            userNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            userNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            userNameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
