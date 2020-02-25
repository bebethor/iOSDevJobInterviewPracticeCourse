//
//  UserInfViewController.swift
//  GitHubFollowers
//
//  Created by Jose Alberto on 24/02/2020.
//  Copyright © 2020 JARCG. All rights reserved.
//

import UIKit

class UserInfViewController: UIViewController {
    
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        title = username
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dissmisVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc func dissmisVC() {
        dismiss(animated: true, completion: nil)
    }
}
