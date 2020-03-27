//
//  GHFItemInfoViewController.swift
//  GitHubFollowers
//
//  Created by Jose Alberto Ruíz-Carrillo González on 09/03/2020.
//  Copyright © 2020 JARCG. All rights reserved.
//

import UIKit

class GHFItemInfoViewController: UIViewController {
    
    // MARK: - UIElements -
    let stackView        = UIStackView()
    let itemInfoViewOne  = GHFItemInfoView()
    let itemInfoViewTwo  = GHFItemInfoView()
    let actionButton     = GHFButton()
    
    // MARK: - Properties -
    var user: User!
    weak var delegate: UserInfoViewControllerDelegate!
    
    // MARK: - Inits -
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lyfe Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        configureActionButton()
        autoLayoutUI()
        configureStackView()
    }
    
    // MARK: - Confgure UI -
    private func configureBackgroundView() {
        view.layer.cornerRadius = 18
        view.backgroundColor    = .secondarySystemBackground
    }
    
    private func configureStackView() {
        stackView.axis          = .horizontal
        stackView.distribution  = .equalSpacing
        
        stackView.addArrangedSubview(itemInfoViewOne)
        stackView.addArrangedSubview(itemInfoViewTwo)
    }
    
    private func configureActionButton() {
        self.actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
    // this func is overriden in the GHFItemInfoViewController subclasses (GHFReposItemViewController, GHFFollowerItemViewController)
    @objc func actionButtonTapped() {}
    
    private func autoLayoutUI() {        
        view.addSubviews(stackView, actionButton)
        
        let padding: CGFloat = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
