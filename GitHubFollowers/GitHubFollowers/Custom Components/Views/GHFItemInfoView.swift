//
//  GHFItemInfoView.swift
//  GitHubFollowers
//
//  Created by Jose Alberto Ruíz-Carrillo González on 06/03/2020.
//  Copyright © 2020 JARCG. All rights reserved.
//

import UIKit

enum infoItemType {
    case repos, gists, followers, following
}

class GHFItemInfoView: UIView {
    
    // MARK: - UI Elements -
    let symbolImageView     = UIImageView()
    let titleLabel          = GHFTitleLabel(textAlignment: .left, fontSize: 14)
    let countLabel          = GHFTitleLabel(textAlignment: .center, fontSize: 14)
    
    // MARK: - Properties -
    var uiItemsArray       = [UIView]()
    
    // MARK: - Inits -
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure Functions -
    func configure() {
        uiItemsArray = [symbolImageView, titleLabel, countLabel]
        
        for item in self.uiItemsArray {
            addSubview(item)
        }
        
        configureSymbolImageView()
        configureTitleLabel()
        configureCountingReposLabel()
    }
    
    func configureSymbolImageView() {
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor   = .label
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func configureTitleLabel() {
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    func configureCountingReposLabel() {
        NSLayoutConstraint.activate([
            countLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    func set(infoItemType: infoItemType, withCount count: Int) {
        switch infoItemType {
        case .repos:
            symbolImageView.image = UIImage(systemName: SFSymbols.repos)
            titleLabel.text       = "Public Repos"
        case .gists:
            symbolImageView.image = UIImage(systemName: SFSymbols.gists)
            titleLabel.text       = "Public Gists"
        case .followers:
            symbolImageView.image = UIImage(systemName: SFSymbols.followers)
            titleLabel.text       = "Followers"
        case .following:
            symbolImageView.image = UIImage(systemName: SFSymbols.following)
            titleLabel.text       = "Following"
        }
        countLabel.text = String(count)
    }
}
