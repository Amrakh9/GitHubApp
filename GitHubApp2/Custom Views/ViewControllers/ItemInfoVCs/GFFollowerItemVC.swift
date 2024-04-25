//
//  GFFollowerItemVC.swift
//  GitHubApp2
//
//  Created by Amrah on 24.04.24.
//

import Foundation

class GFFollowerItemVC: GFItemVC{
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
        
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
//HERE HAVE ISSUE (In normal case there are not any question 
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
}
