//
//  UserInfoViewController.swift
//  GitHubFollowers
//
//  Created by Jose Alberto on 24/02/2020.
//  Copyright © 2020 JARCG. All rights reserved.
//

import UIKit

protocol UserInfoViewControllerDelegate: class {
    func didRequestFollowers(for userName: String)
}

class UserInfoViewController: BaseViewController {
    
    // MARK: - IBOUTLETS -
    let headerContainerView          = UIView()
    let itemViewOneContainer         = UIView()
    let itemViewTwoContainer         = UIView()
    let dateLabel                    = GHFBodyLabel(textAligment: .center)
    let scrollView                   = UIScrollView()
    let contentView                  = UIView()
    
    // MARK: - PROPERTIES -
    var itemViewsArray = [UIView]()
    var username: String!
    weak var delegate: UserInfoViewControllerDelegate!

    // MARK: - LYFE CYCLE -
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureScrollView()
        autolayoutUI()
        getUserInfo()
        print(view.bounds.size.height)
    }
    
    // MARK: - CONFIGURE UI -
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = username
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dissmisVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.pinToEdges(of: self.view)
        contentView.pinToEdges(of: scrollView)
        
        // El contentView siempre tiene que saber un alto y un ancho explícito.
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 600)
        ])
    }
    
    func configureUIElements(with user: User) {
        self.add(childVC: GHFUserInfoHeaderViewController(user: user), to: self.headerContainerView) // Add header
        self.add(childVC: GHFReposItemViewController(user: user, delegate: self), to: self.itemViewOneContainer) // Add repo item view
        self.add(childVC:GHFFollowerItemViewController(user: user, delegate: self), to: self.itemViewTwoContainer) // Add follower item view
        self.dateLabel.text = "Github since \(user.createdAt.convertToMonthYearFormat())"
    }
    
    func autolayoutUI() {
        let padding: CGFloat    = 20
        let itemHeight: CGFloat = 140
        
        itemViewsArray = [headerContainerView, itemViewOneContainer, itemViewTwoContainer, dateLabel]
        
        for item in itemViewsArray {
            contentView.addSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                item.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                item.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant:  -padding),
            ])
        }
        
        NSLayoutConstraint.activate([
            headerContainerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerContainerView.heightAnchor.constraint(equalToConstant: 210),
            
            itemViewOneContainer.topAnchor.constraint(equalTo: headerContainerView.bottomAnchor, constant: padding),
            itemViewOneContainer.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwoContainer.topAnchor.constraint(equalTo: itemViewOneContainer.bottomAnchor, constant: padding),
            itemViewTwoContainer.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwoContainer.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 50)
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
}

extension UserInfoViewController: GHFReposItemViewControllerDelegate {
    func didTapGitHubProfileButton(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGHFAlertOnMainThreat(title: "Invalid URL", message: "The URL attached to this user is invalid", buttonTitle: "Ok")
            return
        }
        self.showSafariViewController(with: url)
    }
}

extension UserInfoViewController: GHFFollowerItemViewControllerDelegate {
    func didTapGetFollowersButton(for user: User) {
        guard user.followers != 0 else {
            presentGHFAlertOnMainThreat(title: "No followers", message: "This user has no followers...☹️", buttonTitle: "Ok")
            return
        }

        delegate.didRequestFollowers(for: user.login)
        dissmisVC()
    }
}
