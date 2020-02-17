//
//  GHFAlertViewController.swift
//  GitHubFollowers
//
//  Created by Jose Alberto on 17/02/2020.
//  Copyright © 2020 JARCG. All rights reserved.
//

import UIKit

class GHFAlertViewController: UIViewController {
    
    // MARK: - UI elements -
    let containerView = UIView() // contains titleLabel, messageLabel & actionButton
    let titleLabel    = GHFTitleLabel(textAligment: .center, fontSize: 20)
    let messageLabel  = GHFBodyLabel(textAligment: .center)
    let actionButton  = GHFButton(backgroundColor: .systemPink, title: "Ok")
    
    // MARK: - Properties -
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    
    // MARK: - Init -
    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.alertTitle   = title
        self.message      = message
        self.buttonTitle  = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
    }
}
