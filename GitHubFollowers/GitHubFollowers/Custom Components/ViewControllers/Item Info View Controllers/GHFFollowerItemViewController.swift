//
//  GHFFollowerItemViewController.swift
//  GitHubFollowers
//
//  Created by Jose Alberto Ruíz-Carrillo González on 09/03/2020.
//  Copyright © 2020 JARCG. All rights reserved.
//

import UIKit

class GHFFollowerItemViewController: GHFItemInfoViewController {
    
    // MARK: - Lyfe Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    override func actionButtonTapped() {
        delegate.didTapGetFollowersButton(for: user)
    }
    
    private func configureItems() {
        itemInfoViewOne.set(infoItemType: .followers, withCount: user.publicRepos)
        itemInfoViewTwo.set(infoItemType: .following, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
}
