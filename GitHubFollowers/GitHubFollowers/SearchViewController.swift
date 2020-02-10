//
//  SearchViewController.swift
//  GitHubFollowers
//
//  Created by Jose Alberto Ruíz-Carrillo González on 10/02/2020.
//  Copyright © 2020 JARCG. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    var button = GHFButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        
        button = GHFButton(backgroundColor: .systemGreen, title: "ENTER")
        button = GHFButton(frame: CGRect(x: 0.0, y: 0.0, width: 50.0, height: 100.0))
        view.addSubview(button)
    }

}
