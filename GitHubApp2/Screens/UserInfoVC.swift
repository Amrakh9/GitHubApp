//
//  UserInfoVC.swift
//  GitHubApp2
//
//  Created by Amrah on 13.04.24.
//

import UIKit

class UserInfoVC: UIViewController {
    
    let headerView  = UIView()
    let itemView1 = UIView()
    let itemView2 = UIView()

    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        itemView1.backgroundColor = .systemRed
        itemView2.backgroundColor = .systemBlue
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismssVC))
        navigationItem.rightBarButtonItem = doneButton
        
        layoutUI()
        
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
                }
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    
    func layoutUI() {
        view.addSubview(headerView)
        view.addSubview(itemView1)
        view.addSubview(itemView2)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        itemView1.translatesAutoresizingMaskIntoConstraints = false
        itemView2.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemView1.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemView1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemView1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemView1.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemView2.topAnchor.constraint(equalTo: itemView1.bottomAnchor, constant: padding),
            itemView2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemView2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemView2.heightAnchor.constraint(equalToConstant: itemHeight)
        ])
    }
    
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    
    @objc func dismssVC() {
        dismiss(animated: true)
    }
}
