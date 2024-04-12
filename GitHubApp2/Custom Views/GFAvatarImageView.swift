//
//  GFAvatarImageView.swift
//  GitHubApp2
//
//  Created by Amrah on 23.03.24.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let cache = NetworkManager.shared.cache
    let imagePlaceholder = UIImage(named: "avatar-placeholder")

    override init(frame: CGRect) {
        super .init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        layer.cornerRadius = 10
        
        image  = imagePlaceholder
        
        
    }
    
    func downloadImage(from urlSting: String ) {
        //Working on Cashe
        if let image = cache.object(forKey: urlSting as NSString){
            self.image = image
            return
        }
        
        guard let url = URL(string: urlSting) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else {return}
            
            if error != nil { return }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            
            guard let data = data else { return }
            
            guard let image = UIImage(data: data) else { return }
            
            //Downloading to Cache
            self.cache.setObject(image, forKey: urlSting as NSString)
            
            DispatchQueue.main.async { self.image = image }
        }
        task.resume()
    }
    
}
//guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
//    completed(.failure(.invalidData))
//    return
//}
//
//guard let data = data else {
//    completed(.failure(.invalidData))
//    return
//}
//
//do{
//    let decoder = JSONDecoder()
//    decoder.keyDecodingStrategy = .convertFromSnakeCase
//    let followers = try decoder.decode([Follower].self, from: data)
//    completed(.success(followers))
//} catch{
//    completed(.failure(.invalidData))
//    
//}
