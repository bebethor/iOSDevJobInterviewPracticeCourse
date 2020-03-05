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
        itemViewsArray = [headerContainerView, itemViewOneContainer, itemViewTwoContainer]
        
        for item in itemViewsArray {
            view.addSubview(item)
        }
        
        itemViewOneContainer.backgroundColor = .systemPink
        itemViewTwoContainer.backgroundColor = .systemBlue
        
        headerContainerView.translatesAutoresizingMaskIntoConstraints  = false
        itemViewOneContainer.translatesAutoresizingMaskIntoConstraints = false
        itemViewTwoContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat    = 20
        let itemHeight: CGFloat = 140
        
        NSLayoutConstraint.activate([
            headerContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerContainerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOneContainer.topAnchor.constraint(equalTo: headerContainerView.bottomAnchor, constant: padding),
            itemViewOneContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemViewOneContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemViewOneContainer.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwoContainer.topAnchor.constraint(equalTo: itemViewOneContainer.bottomAnchor, constant: padding),
            itemViewTwoContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemViewTwoContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
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
                }
            case .failure(let error):
                self.presentGHFAlertOnMainThreat(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}
