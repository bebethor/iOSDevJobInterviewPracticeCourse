//
//  FavoritesViewController.swift
//  GitHubFollowers
//
//  Created by Jose Alberto Ruíz-Carrillo González on 10/02/2020.
//  Copyright © 2020 JARCG. All rights reserved.
//

import UIKit

class FavoritesViewController: GHFBaseViewController {
    
    // MARK: - UI Elements -
    let tableView = UITableView()
    
    // MARK: - Properties -
    var favoritesFollowers = [Follower]()

    // MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    // MARK: - Functions -
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title                = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame         = view.bounds
        tableView.rowHeight     = 80
        tableView.delegate      = self
        tableView.dataSource    = self
        
        tableView.register(GHFFavoriteTableViewCell.self, forCellReuseIdentifier: GHFFavoriteTableViewCell.reuseID)
    }
    
    func getFavorites() {
        PersistanceManager.retrieveFavorites { [ weak self ] result in
            guard let self = self else { return }
            switch result {
            case .success(let favorites):
                if favorites.isEmpty {
                    self.showEmptyStateView(with: "No favorites\nAdd one on the follower screen.", in: self.view)
                } else {
                    self.favoritesFollowers = favorites
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
            case .failure(let error):
                self.presentGHFAlertOnMainThreat(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}

// MARK: - Extensions -
extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    
    // DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoritesFollowers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let favoriteFollower = favoritesFollowers[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: GHFFavoriteTableViewCell.reuseID) as! GHFFavoriteTableViewCell
        cell.set(favorite: favoriteFollower)
        
        return cell
    }
    
    // Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favoriteFollower = favoritesFollowers[indexPath.row]
        let destinationVC    = FollowersViewController(username: favoriteFollower.login)
        
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        let favorite = favoritesFollowers[indexPath.row]
        favoritesFollowers.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        
        PersistanceManager.updateWith(favorite: favorite, actionType: .remove) { [ weak self ] error in
            guard let self = self else { return }
            guard let error = error else { return }
            self.presentGHFAlertOnMainThreat(title: "Unable to remove", message: error.rawValue, buttonTitle: "Ok")
        }
    }
}
