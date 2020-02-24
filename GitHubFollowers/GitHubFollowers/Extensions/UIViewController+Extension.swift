//
//  UIViewController+Extension.swift
//  GitHubFollowers
//
//  Created by Jose Alberto on 17/02/2020.
//  Copyright © 2020 JARCG. All rights reserved.
//

import UIKit

fileprivate var containerView: UIView!
fileprivate var activityIndicator: UIActivityIndicatorView!

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
        containerView.alpha           = 0
        
        UIView.animate(withDuration: 0.25) { containerView.alpha = 0.8 }
        
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .systemRed
        containerView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
    }
    
    func dismissLoading() {
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
            activityIndicator.stopAnimating()
        } 
    }
    
    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView      = GHFEmptyStateView(message: message)
        emptyStateView.frame    = view.bounds
        
    }
}
