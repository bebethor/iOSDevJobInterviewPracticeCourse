//
//  FollowersViewController.swift
//  GitHubFollowers
//
//  Created by Jose Alberto Ruíz-Carrillo González on 10/02/2020.
//  Copyright © 2020 JARCG. All rights reserved.
//

import UIKit

class FollowersViewController: UIViewController {
    enum Section { case main }
    
    // MARK: - Outlets -
    var collectionView: UICollectionView!

    // MARK: - Properties -
    var userName: String!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var page: Int = 1
    var hasMoreFollowers: Bool = true
    var isSearching: Bool = false
    
    // MARK: - Lyfe cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        configureSearchController()
        getFollowers(username: userName, page: page)
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: - Configure UI -
    func configureViewController() {
        view.backgroundColor                                    = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles  = true
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.threeColumnsFlowLauyout(in: view))
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(GHFCollectionViewCell.self, forCellWithReuseIdentifier: GHFCollectionViewCell.reuseID)
    }
    
    func configureSearchController() {
        let searchController                                   = UISearchController()
        searchController.searchResultsUpdater                  = self
        searchController.searchBar.delegate                    = self
        searchController.searchBar.placeholder                 = "Search Username"
        searchController.obscuresBackgroundDuringPresentation  = false
        navigationItem.searchController                        = searchController
    }
    
    // MARK: - Functions -
    func getFollowers(username: String, page: Int) {
        showLoading()
        NetworkManager.shared.getFollowers(for: userName, page: page) { [weak self] (result) in
            guard let self = self else { return }
            self.dismissLoading()
            switch result {
            case .success(let followers):
                if followers.count < 100 { self.hasMoreFollowers = false }
                self.followers.append(contentsOf: followers)
                
                if self.followers.isEmpty {
                    let message = "This user doesn´t have followers. Go follow this user!!"
                    DispatchQueue.main.async { self.showEmptyStateView(with: message, in: self.view) }
                    return
                }
                
                self.updateData(on: self.followers)
            case .failure(let error):
                self.presentGHFAlertOnMainThreat(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    // MARK: - Diffable datasource -
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView,
            indexPath, follower) -> UICollectionViewCell? in
            // Create the cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GHFCollectionViewCell.reuseID, for: indexPath) as! GHFCollectionViewCell
            // Configure the cell
            cell.set(follower: follower)
            // Return cell
            return cell
        })
    }
    
    func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true, completion: nil) }
    }
}

// MARK: - Extensions -
extension FollowersViewController: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        // Detect the bottom of the scrollView
        if offsetY > contentHeight - height {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(username: userName, page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray          = isSearching ? filteredFollowers : followers
        let follower             = activeArray[indexPath.item]
        
        let destinationVC        = UserInfoViewController()
        destinationVC.username   = follower.login
        let navigationController = UINavigationController(rootViewController: destinationVC)
        
        present(navigationController, animated: true, completion: nil)
        
    }
}

extension FollowersViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        isSearching       = true
        
        // $0.represents a follower.
        filteredFollowers = followers.filter( { return $0.login.lowercased().contains(filter.lowercased()) } )
        updateData(on: filteredFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(on: self.followers)
    }
}
