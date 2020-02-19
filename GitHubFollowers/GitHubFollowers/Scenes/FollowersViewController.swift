//
//  FollowersViewController.swift
//  GitHubFollowers
//
//  Created by Jose Alberto Ruíz-Carrillo González on 10/02/2020.
//  Copyright © 2020 JARCG. All rights reserved.
//

import UIKit

class FollowersViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    // MARK: - Outlets -
    var collectionView: UICollectionView!

    // MARK: - Properties -
    var userName: String!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    var followers: [Follower] = []
    
    // MARK: Lyfe cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getFollowers()
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureViewController() {
        view.backgroundColor                                    = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles  = true
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: threeColumnsFlowLauyout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(GHFCollectionViewCell.self, forCellWithReuseIdentifier: GHFCollectionViewCell.reuseID)
    }
    
    func threeColumnsFlowLauyout() -> UICollectionViewFlowLayout {
        let width                       = view.bounds.width
        let padding: CGFloat            = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth              = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth                   = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
    
    func getFollowers() {
        NetworkManager.shared.getFollowers(for: userName, page: 1) { (result) in
            switch result {
            case .success(let followers):
                self.followers = followers
                self.updateData()
            case .failure(let error):
                self.presentGHFAlertOnMainThreat(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
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
    
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true, completion: nil) }
    }
}
