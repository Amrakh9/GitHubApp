//
//  FollowerListViewController.swift
//  GitHubApp2
//
//  Created by Amrah on 12.03.24.
//
// 4:39:02
import UIKit

class FollowerListViewController: UIViewController {

    var username: String!
    var collectionView: UICollectionView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        configueViewController()
        getFollowers()
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        
    }
    func configueViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLeyaut())
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = .systemMint
        collectionView.register(FollowerCollectionViewCell.self, forCellWithReuseIdentifier: FollowerCollectionViewCell.reuseID)
    }
    
    func createThreeColumnFlowLeyaut() -> UICollectionViewFlowLayout{
        let width               = view.bounds .width
        let padding: CGFloat    = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth  = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)

        return flowLayout
    }
    
    
    
    func getFollowers(){
        NetworkManager.shared.getFollowers(for: username, page: 1) { result in
            switch result {
            case .success(let followers):
                print("followers count = \(followers.count)")
                print(followers)
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Test", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}
