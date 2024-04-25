//
//  FavouritesViewController.swift
//  GitHubApp2
//
//  Created by Amrah on 11.03.24.
//

import UIKit

class FavouritesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        
        
        PersistanceManager.retrieveFavorites { result in
            switch result{
            case .success(let favorites):
                print(favorites)
            case .failure(let error):
                break
            }
        }
    }
}
