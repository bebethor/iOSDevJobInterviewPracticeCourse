//
//  GHFImageView.swift
//  GitHubFollowers
//
//  Created by Jose Alberto on 19/02/2020.
//  Copyright © 2020 JARCG. All rights reserved.
//

import UIKit

class GHFImageView: UIImageView {
    
    let placeHolderImage = Images.avatarPlaceholder
    let cache = NetworkManager.shared.cache
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Custom code here
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius  = 10
        clipsToBounds       = true
        image               = placeHolderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadAvatarImage(fromURL url: String) {
        NetworkManager.shared.downloadImage(from: url) { [ weak self ] image in
            guard let self = self else { return }
            DispatchQueue.main.async { self.image = image }
        }
    }
}
