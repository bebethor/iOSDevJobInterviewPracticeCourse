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
    let button: GHFButton            = GHFButton(backgroundColor: .systemRed, title: "Get followers")    
    
    // MARK: - Properties -
    var isUserNameEntered: Bool {
        return !userTextField.text!.isEmpty
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground // light mode white / dark mode black
        view.addSubviews(logoImageView, userTextField, button)
        configureLogoImageView()
        configureUserTextField()
        configureButton()
        dismissKeyBoardTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        //userTextField.text?.removeAll()
        userTextField.text = ""
    }
    
    // MARK: - Configure UI -
    func configureLogoImageView() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = Images.ghLogo
        
        let topConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20 : 80
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraintConstant),// anchor to top (vertical)
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor), // center x anchor. Center horizontally
            logoImageView.widthAnchor.constraint(equalToConstant: 200), // width
            logoImageView.heightAnchor.constraint(equalToConstant: 200) // height
        ])
    }
    
    func configureUserTextField() {
        userTextField.delegate = self
        NSLayoutConstraint.activate([
            userTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            userTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50), // left
            userTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50), // right
            userTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureButton() {
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50), // left
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50), // right
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: - Functions -
    func dismissKeyBoardTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Actions -
    @objc func buttonPressed() {
        guard isUserNameEntered else {
            print("No user name entered")
            presentGHFAlertOnMainThreat(title: "Empty username", message: "You need to enter a username to look for 👾", buttonTitle: "Ok")
            return
        }
        
        userTextField.resignFirstResponder()
        
        let followersViewController       = FollowersViewController(username: userTextField.text!) // Se fuerza el desempaquetado por que ya se hace la comprobación de que tengamos texto en el botón
        
        navigationController?.pushViewController(followersViewController, animated: true)
    }
}

// MARK: - Extensions -
extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        buttonPressed()
        self.view.endEditing(true)
        return true
    }
}
