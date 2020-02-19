//
//  GHFCollectionViewCell.swift
//  GitHubFollowers
//
//  Created by Jose Alberto on 19/02/2020.
//  Copyright © 2020 JARCG. All rights reserved.
//

import UIKit

class GHFCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "FollowerCell"
    
    let avatarImage = UIImage()
    let userNameLabel = GHFTitleLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
