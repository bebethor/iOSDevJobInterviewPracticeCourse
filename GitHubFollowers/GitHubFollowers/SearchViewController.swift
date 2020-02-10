//
//  SearchViewController.swift
//  GitHubFollowers
//
//  Created by Jose Alberto Ruíz-Carrillo González on 10/02/2020.
//  Copyright © 2020 JARCG. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    // MARK: - UI Elements -
    let logoImageView: UIImageView   = UIImageView()
    let userTextField: GHFTextField  = GHFTextField()
    let button: GHFButton            = GHFButton(backgroundColor: .systemGreen, title: "Get followers")
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground // light mode white / dark mode black
        configureLogoImageView()
        configureUserTextField()
        configureButton()
        createDismissKeyBoardTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Configure UI -
    func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "gh-logo")
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80), // anchor to top (vertical)
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor), // center x anchor. Center horizontally
            logoImageView.widthAnchor.constraint(equalToConstant: 200), // width
            logoImageView.heightAnchor.constraint(equalToConstant: 200) // height
        ])
    }
    
    func configureUserTextField() {
        view.addSubview(userTextField)
        NSLayoutConstraint.activate([
            userTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            userTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50), // left
            userTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50), // right
            userTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureButton() {
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50), // left
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50), // right
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: - Functions -
    func createDismissKeyBoardTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tapGesture)
    }
}
