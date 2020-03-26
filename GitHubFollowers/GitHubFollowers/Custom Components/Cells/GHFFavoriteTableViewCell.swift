//
//  GHFFavoriteTableViewCell.swift
//  GitHubFollowers
//
//  Created by Jose Alberto Ruíz-Carrillo González on 19/03/2020.
//  Copyright © 2020 JARCG. All rights reserved.
//

import UIKit

class GHFFavoriteTableViewCell: UITableViewCell {

    // MARK: - UI Elements -
    static let reuseID   = "FavoritCell"
    let avatarImageView  = GHFImageView(frame: .zero)
    let userNameLabel    = GHFTitleLabel(textAlignment: .left, fontSize:16)
    
    // MARK: - Inits -
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure UI functions -
    func set(favorite: Follower) {
        userNameLabel.text = favorite.login
        NetworkManager.shared.downloadImage(from: favorite.avatarUrl) { [ weak self ] image in
            guard let self = self else { return }
            DispatchQueue.main.async { self.avatarImageView.image = image }
        }
    }
    
    func configure() {
        addSubview(avatarImageView)
        addSubview(userNameLabel)
        
        accessoryType = .disclosureIndicator
        let padding: CGFloat = 12
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            
            userNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
            userNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            userNameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
