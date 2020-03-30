//
//  FollowersViewController.swift
//  GitHubFollowers
//
//  Created by Jose Alberto Ruíz-Carrillo González on 10/02/2020.
//  Copyright © 2020 JARCG. All rights reserved.
//

import UIKit

class FollowersViewController: BaseViewController {
    
    enum Section { case main }
    
    // MARK: - Outlets -
    var collectionView: UICollectionView!

    // MARK: - Properties -
    var username: String!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    var followers: [Follower]         = []
    var filteredFollowers: [Follower] = []
    var page: Int                     = 1
    var hasMoreFollowers: Bool        = true
    var isSearching: Bool             = false
    var isLoadingMoreFollowers        = false
    
    // MARK: - Initializers -
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username   = username
        title           = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lyfe cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        configureSearchController()
        getFollowers(username: username, page: page)
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
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
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
        searchController.searchBar.placeholder                 = "Search Username"
        searchController.obscuresBackgroundDuringPresentation  = false
        navigationItem.searchController                        = searchController
    }
    
    // MARK: - Functions -
    func getFollowers(username: String, page: Int) {
        showLoading()
        isLoadingMoreFollowers = true
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] (result) in
            guard let self = self else { return }
            self.dismissLoading()
            
            switch result {
            case .success(let followers):
                self.updateUI(with: followers)
            case .failure(let error):
                self.presentGHFAlertOnMainThreat(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            }
            self.isLoadingMoreFollowers = false
        }
    }
    
    // MARK: - Functions -
    func updateUI(with followers: [Follower]) {
        if followers.count < 100 { self.hasMoreFollowers = false }
        self.followers.append(contentsOf: followers)
        
        if self.followers.isEmpty {
            let message = "This user doesn´t have followers. Go follow this user!!"
            DispatchQueue.main.async { self.showEmptyStateView(with: message, in: self.view) }
            return
        }
        
        self.updateData(on: self.followers)
    }
    
    func addUserToFavorites(user: User) {
        let favoriteFollower = Follower(login: user.login, avatarUrl: user.avatarUrl)
        PersistanceManager.updateWith(favorite: favoriteFollower, actionType: .add) { error in
            guard let error = error else {
                self.presentGHFAlertOnMainThreat(title: "Succes!!!", message: "You have successfully favorited this user 🎉!!!", buttonTitle: "Ok")
                return
            }
            self.presentGHFAlertOnMainThreat(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
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
    
    // MARK: - Actions -
    @objc func addButtonTapped() {
        showLoading()
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoading()
            switch result {
            case .success(let user):
                self.addUserToFavorites(user: user)
            case .failure(let error):
                self.presentGHFAlertOnMainThreat(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
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
            guard hasMoreFollowers, !isLoadingMoreFollowers else { return }
            page += 1
            getFollowers(username: username, page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray          = isSearching ? filteredFollowers : followers
        let follower             = activeArray[indexPath.item]
        
        let destinationVC        = UserInfoViewController()
        destinationVC.username   = follower.login
        destinationVC.delegate   = self
        let navigationController = UINavigationController(rootViewController: destinationVC)
        
        present(navigationController, animated: true, completion: nil)
        
    }
}

extension FollowersViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filteredFollowers.removeAll()
            updateData(on: followers)
            isSearching = false
            return
        }
        isSearching       = true
        // $0.represents a follower.
        filteredFollowers = followers.filter( { return $0.login.lowercased().contains(filter.lowercased()) } )
        updateData(on: filteredFollowers)
    }
}

extension FollowersViewController: UserInfoViewControllerDelegate {
    func didRequestFollowers(for username: String) {
        self.username = username
        title         = username
        page          = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        getFollowers(username: username, page: page )
    }
}
