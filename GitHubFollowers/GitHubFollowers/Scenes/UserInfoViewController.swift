//
//  UserInfoViewController.swift
//  GitHubFollowers
//
//  Created by Jose Alberto on 24/02/2020.
//  Copyright © 2020 JARCG. All rights reserved.
//

import UIKit

class UserInfoViewController: UIViewController {
    
    // MARK: - IBOUTLETS -
    let headerContainerView          = UIView()
    let itemViewOneContainer         = UIView()
    let itemViewTwoContainer         = UIView()
    
    // MARK: - PROPERTIES -
    var itemViewsArray = [UIView]()
    var username: String!

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
        
        itemViewsArray = [headerContainerView, itemViewOneContainer, itemViewTwoContainer]
        
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
            itemViewTwoContainer.heightAnchor.constraint(equalToConstant: itemHeight)
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
                    self.add(childVC: GHFUserInfoHeaderViewController(user: user), to: self.headerContainerView)
                    self.add(childVC: GHFReposItemViewController(user: user), to: self.itemViewOneContainer)
                    self.add(childVC: GHFFollowerItemViewController(user: user), to: self.itemViewTwoContainer)
                }
            case .failure(let error):
                self.presentGHFAlertOnMainThreat(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}
