//
//  UIViewController+Extension.swift
//  GitHubFollowers
//
//  Created by Jose Alberto on 17/02/2020.
//  Copyright © 2020 JARCG. All rights reserved.
//

import UIKit
import SafariServices

extension UIViewController {
    func presentGHFAlertOnMainThreat(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertViewController = GHFAlertViewController(title: title, message: message, buttonTitle: buttonTitle)
            alertViewController.modalPresentationStyle = .overFullScreen
            alertViewController.modalTransitionStyle = .crossDissolve // fade in
            self.present(alertViewController, animated: true)
        }
    }
    
    func showSafariViewController(with url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.preferredControlTintColor = .systemGreen
        present(safariViewController, animated: true)
    }
}
