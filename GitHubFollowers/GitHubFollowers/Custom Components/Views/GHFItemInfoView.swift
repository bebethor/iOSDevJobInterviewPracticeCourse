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
    
    // MARK: - Properties -
    var uiItemsArray     = [UIView]()
    
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
        uiItemsArray = [symbolImageView, titleLabel, countingReposLabel]
        
        for item in uiItemsArray {
            addSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false
        }
        
        configureSymbolImageView()
        configureTitleLabel()
        configureCountingReposLabel()
    }
    
    func configureSymbolImageView() {
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor   = .label
        
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
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    func configureCountingReposLabel() {
        NSLayoutConstraint.activate([
            countingReposLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            countingReposLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countingReposLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countingReposLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
}
