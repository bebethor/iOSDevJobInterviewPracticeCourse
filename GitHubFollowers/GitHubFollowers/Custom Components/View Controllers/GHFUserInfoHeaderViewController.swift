//
//  GHFUserInfoHeaderViewController.swift
//  GitHubFollowers
//
//  Created by Jose Alberto Ruíz-Carrillo González on 04/03/2020.
//  Copyright © 2020 JARCG. All rights reserved.
//

import UIKit

class GHFUserInfoHeaderViewController: UIViewController {
    
    // MARK: - OUTLETS -
    let avatarImageView     = GHFImageView(frame: .zero)
    let userNameLabel       = GHFTitleLabel(textAlignment: .left, fontSize: 34)
    let nameLabel           = GHFSecondaryTitleLabel(fontSize: 18)
    let locationImageView   = UIImageView()
    let locationLabel       = GHFSecondaryTitleLabel(fontSize: 18)
    let bioLabel            = GHFBodyLabel(textAligment: .left)
    var viewsArray          = [UIView]()
    
    var user: User!
    
    // MARK: - Inits -
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        autoLayoutUI()
    }
    
    func configureUIElements() {
        avatarImageView.downLoadImage(from: user.avatarUrl)
        userNameLabel.text      = user.login
        nameLabel.text          = user.name ?? ""
        locationImageView.image = UIImage(systemName: SFSymbols.location)
        locationLabel.text      = user.location ?? "No location"
        bioLabel.text           = user.bio ?? "No bio"
        bioLabel.numberOfLines  = 3
        
    }
    
    func addSubviews() {
        viewsArray.append(contentsOf: [avatarImageView, userNameLabel,nameLabel, locationImageView, bioLabel])
        for view in viewsArray {
            view.addSubview(view)
        }
    }
    
    func autoLayoutUI() {
        let padding: CGFloat          = 20
        let textImagePadding: CGFloat = 12
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            
            userNameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            userNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            userNameLabel.heightAnchor.constraint(equalToConstant: 38),
            
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            
            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: textImagePadding),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: textImagePadding),
            bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: avatarImageView.trailingAnchor),
            bioLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
