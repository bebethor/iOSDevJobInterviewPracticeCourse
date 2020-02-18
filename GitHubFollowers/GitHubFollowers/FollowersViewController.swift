//
//  FollowersViewController.swift
//  GitHubFollowers
//
//  Created by Jose Alberto Ruíz-Carrillo González on 10/02/2020.
//  Copyright © 2020 JARCG. All rights reserved.
//

import UIKit

class FollowersViewController: UIViewController {

    var userName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor                                    = .systemBackground
        navigationController?.isNavigationBarHidden             = false
        navigationController?.navigationBar.prefersLargeTitles  = true
    }
}