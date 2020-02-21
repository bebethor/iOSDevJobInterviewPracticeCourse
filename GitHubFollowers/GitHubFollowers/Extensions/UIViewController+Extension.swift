//
//  UIViewController+Extension.swift
//  GitHubFollowers
//
//  Created by Jose Alberto on 17/02/2020.
//  Copyright © 2020 JARCG. All rights reserved.
//

import UIKit

fileprivate var containerView: UIView!

extension UIViewController {
    func presentGHFAlertOnMainThreat(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertViewController = GHFAlertViewController(title: title, message: message, buttonTitle: buttonTitle)
            alertViewController.modalPresentationStyle = .overFullScreen
            alertViewController.modalTransitionStyle = .crossDissolve // fade in
            self.present(alertViewController, animated: true)
        }
    }
    
    func showLoading() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
    }
}
