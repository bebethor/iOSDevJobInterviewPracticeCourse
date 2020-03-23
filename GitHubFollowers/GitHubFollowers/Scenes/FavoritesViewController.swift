//
//  FavoritesViewController.swift
//  GitHubFollowers
//
//  Created by Jose Alberto Ruíz-Carrillo González on 10/02/2020.
//  Copyright © 2020 JARCG. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    // MARK: - UI Elements -
    let tableView = UITableView()
    
    // MARK: - Properties -
    var favoritesFollowers = [Follower]()

    // MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        getFavorites()
    }
    
    // MARK: - Functions -
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title                = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func getFavorites() {
        PersistanceManager.retrieveFavorites { ( result ) in
            switch result {
            case .success(let favorites):
                self.favoritesFollowers = favorites
                print(self.favoritesFollowers)
            case .failure(let error):
                break
            }
        }
    }
}
