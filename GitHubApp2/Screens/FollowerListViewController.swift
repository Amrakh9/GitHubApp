//
//  FollowerListViewController.swift
//  GitHubApp2
//
//  Created by Amrah on 12.03.24.
//
// 4:39:02
import UIKit

class FollowerListVC: UIViewController {
    
    enum Section { case main }
    
    var username: String!
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var page = 1
    var hasMoreFollowers = true
    var isSearching = false
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()
        getFollowers(username: username, page: page)
        configureDataSource()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    

    func configureCollectionView() {
        let layout = UIHelper.createThreeColumnFlowLayout(in: view)
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCollectionViewCell.self, forCellWithReuseIdentifier: FollowerCollectionViewCell.reuseID)
        collectionView.reloadData() // Reload data after setting layout
    }
    
    //Search Controller
    func configureSearchController(){
        let searchController  = UISearchController()
        searchController.searchResultsUpdater            = self
        searchController.searchBar.delegate              = self
        navigationItem.hidesSearchBarWhenScrolling       = false
        searchController.searchBar.placeholder           = "Search for the username"
        navigationItem.searchController                  = searchController
    }
    
    
    func getFollowers(username: String, page: Int) {
        
        showLoadingView()
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let followers):
                if followers.count < 100 { self.hasMoreFollowers = false }
                self.followers.append(contentsOf: followers)
                //This is old one in which when we scroll down we will only see 100 users, meaning in list there only be 100 at once
                //self.followers = followers
                
                //Showing EmptyStateView if followers is Empty
                if self.followers.isEmpty {
                    let message = "This user does't have any followers. Go follow them 🌚"
                    DispatchQueue.main.async {
                        self.showEmptyStateView(with: message, in: self.view)
                        return
                    }
                }
                self.updateData(on: self.followers)
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad Stuff Happend", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    
    func configureDataSource() {
        
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCollectionViewCell.reuseID, for: indexPath) as! FollowerCollectionViewCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    
    func updateData(on followers: [Follower]) {
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
        
    }
}
//Pagination
extension FollowerListVC: UICollectionViewDelegate{
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if (offsetY > contentHeight - height){
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(username: username, page: page)
        }
    }
    // This is our firt step to make transition to user profile screen. We wrote didselet btw
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // W ? T : F
        let activeArray     = isSearching ? filteredFollowers : followers
        let follower        = activeArray[indexPath.item]
        
        let userInfoVC      = UserInfoVC()
        userInfoVC.username = follower.login
        
        let navController   = UINavigationController(rootViewController: userInfoVC)
        present(navController, animated: true)
        
    }
    
}

// What this is doing?
// It is letting ViewController to know that everytime I changed the search results in the search bar it is letting me know that smt is changed
extension FollowerListVC: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        isSearching = true
        filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased())}
        updateData(on: filteredFollowers)
    }
    
    //When we tap cancel button it will show original followers array rather than filtered one
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(on: followers)
    }
}
