//
//  GHFTabBarController.swift
//  GitHubFollowers
//
//  Created by Jose Alberto Ruíz-Carrillo González on 24/03/2020.
//  Copyright © 2020 JARCG. All rights reserved.
//

import UIKit

class GHFTabBarController: UITabBarController {

    // MARK: - Lyfe Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabbarController()
    }
    
    // MARK: - Configure methods -
    func createSearchNavigationViewController() -> UINavigationController {
        let searchViewController = SearchViewController()
        searchViewController.title = "SEARCH"
        searchViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchViewController)
    }
    
    func createFavoritesNavigationViewController() -> UINavigationController {
        let favoritesViewController = FavoritesViewController()
        favoritesViewController.title = "FAVORITES"
        favoritesViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favoritesViewController)
    }
    
    func configureTabbarController() {
        UITabBar.appearance().tintColor = .systemRed
        viewControllers = [createSearchNavigationViewController(), createFavoritesNavigationViewController()]
    }
}
