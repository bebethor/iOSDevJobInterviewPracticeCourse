//
//  UserInfoViewController.swift
//  GitHubFollowers
//
//  Created by Jose Alberto on 24/02/2020.
//  Copyright © 2020 JARCG. All rights reserved.
//

import UIKit

protocol UserInfoViewControllerDelegate: class {
    func didTapGitHubProfileButton(for user: User)
    func didTapGetFollowersButton(for user: User)
}

class UserInfoViewController: UIViewController {
    
    // MARK: - IBOUTLETS -
    let headerContainerView          = UIView()
    let itemViewOneContainer         = UIView()
    let itemViewTwoContainer         = UIView()
    let dateLabel                    = GHFBodyLabel(textAligment: .center)
    
    // MARK: - PROPERTIES -
    var itemViewsArray = [UIView]()
    var username: String!
    weak var delegate: FollowersViewControllerDelegate!

    // MARK: - LYFE CYCLE -
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        autolayoutUI()
        getUserInfo()
    }
    
    // MARK: - CONFIGURE UI -
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = username
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dissmisVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func autolayoutUI() {
        let padding: CGFloat    = 20
        let itemHeight: CGFloat = 140
        
        itemViewsArray = [headerContainerView, itemViewOneContainer, itemViewTwoContainer, dateLabel]
        
        for item in itemViewsArray {
            view.addSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                item.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                item.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -padding),
            ])
        }
        
        NSLayoutConstraint.activate([
            headerContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            headerContainerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOneContainer.topAnchor.constraint(equalTo: headerContainerView.bottomAnchor, constant: padding),
            itemViewOneContainer.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwoContainer.topAnchor.constraint(equalTo: itemViewOneContainer.bottomAnchor, constant: padding),
            itemViewTwoContainer.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwoContainer.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    // MARK: - FUNCTIONS -
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc func dissmisVC() {
        dismiss(animated: true, completion: nil)
    }
    
    func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) { [ weak self ] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.configureUIElements(with: user)
                }
            case .failure(let error):
                self.presentGHFAlertOnMainThreat(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func configureUIElements(with user: User) {
        // Add header
        self.add(childVC: GHFUserInfoHeaderViewController(user: user), to: self.headerContainerView)
        
        // Add repo item view
        let repoViewController      = GHFReposItemViewController(user: user)
        repoViewController.delegate = self
        self.add(childVC: repoViewController, to: self.itemViewOneContainer)
        
        // Add follower item view
        let followerItemViewController      = GHFFollowerItemViewController(user: user)
        followerItemViewController.delegate = self
        self.add(childVC:followerItemViewController, to: self.itemViewTwoContainer)
        
        self.dateLabel.text = "Github Since \(user.createdAt.convertDateToDisplayFormat())"
    }
}

extension UserInfoViewController: UserInfoViewControllerDelegate {
    func didTapGitHubProfileButton(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGHFAlertOnMainThreat(title: "Invalid URL", message: "The URL attached to this user is invalid", buttonTitle: "Ok")
            return
        }
        self.showSafariViewController(with: url)
    }
    
    func didTapGetFollowersButton(for user: User) {
        guard user.followers != 0 else {
            presentGHFAlertOnMainThreat(title: "No followers", message: "This user has no followers...☹️", buttonTitle: "Ok")
            return
        }
    
        delegate.didRequestFollowers(for: user.login)
        dissmisVC()
    }
}
