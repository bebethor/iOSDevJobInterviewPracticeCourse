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
        
        NetworkManager.shared.getUserInfo(for: username) { [ weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                print(user)
            case .failure(let error):
                self.presentGHFAlertOnMainThreat(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    @objc func dissmisVC() {
        dismiss(animated: true, completion: nil)
    }
    
//    func getFollowers(username: String, page: Int) {
//        showLoading()
//        NetworkManager.shared.getFollowers(for: userName, page: page) { [weak self] (result) in
//            guard let self = self else { return }
//            self.dismissLoading()
//            switch result {
//            case .success(let followers):
//                if followers.count < 100 { self.hasMoreFollowers = false }
//                self.followers.append(contentsOf: followers)
//
//                let message = "This user doesn´t have followers. Go follow this user!!"
//                if self.followers.isEmpty {
//                    DispatchQueue.main.async { self.showEmptyStateView(with: message, in: self.view) }
//                    return
//                }
//
//                self.updateData(on: self.followers)
//            case .failure(let error):
//                self.presentGHFAlertOnMainThreat(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
//            }
//        }
//    }
}
