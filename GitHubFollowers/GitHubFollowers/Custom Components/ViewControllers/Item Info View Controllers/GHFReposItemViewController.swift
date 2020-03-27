//
//  GHFReposItemViewController.swift
//  GitHubFollowers
//
//  Created by Jose Alberto Ruíz-Carrillo González on 09/03/2020.
//  Copyright © 2020 JARCG. All rights reserved.
//

import UIKit

protocol GHFReposItemViewControllerDelegate: class {
    func didTapGitHubProfileButton(for user: User)
}

class GHFReposItemViewController: GHFItemInfoViewController {
    
    weak var delegate: GHFReposItemViewControllerDelegate!

    // MARK: - Lyfe Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    override func actionButtonTapped() {
        delegate.didTapGitHubProfileButton(for: user)
    }
    
    private func configureItems() {
        itemInfoViewOne.set(infoItemType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(infoItemType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "Github Profile")
    }
}
