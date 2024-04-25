//
//  PersistanceManager.swift
//  GitHubApp2
//
//  Created by Amrah on 25.04.24.
//


import Foundation

enum PersistanceActionType {
    case add, remove
}
enum PersistanceManager {
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    //Updating one user
    static func updateWith(favorite: Follower, actionType: PersistanceActionType, completed: @escaping (GFError?) -> Void){
        //So first of all even if we will delete or add user to UserDefaults we need to access it first
        retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                var retrievedFavorites = favorites
                switch actionType{
                case .add:
                    guard !retrievedFavorites.contains(favorite) else {
                        completed(.alredyInFavorites)
                        return
                    }
                    retrievedFavorites.append(favorite)
                case .remove:
                    retrievedFavorites.removeAll{$0.login == favorite.login}
                }
                completed(save(favorites: retrievedFavorites))
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    //MARK: RETRIVE FUNCTION
    //When we are retriving we need to decode
    // 1) We are gonna call retrive function. In the success case it is gonna be array of followers, in the fail case it is gonna be Error pop-up
    //When using user defaults we need to specify key value.
    
    static func retrieveFavorites(completed: @escaping (Result<[Follower], GFError>) -> Void){
        
        //in here we are reaching to user defaults and seeing what we have.
        //in the first use case if there is noting there it gonna return nil and we are gonna return empty array
        guard let favouritesData = defaults.object(forKey: Keys.favorites) as? Data else { completed(.success([]))
            return
        }
        
        //if there is smt in there we are gonna get that data as favorites data and we are gonna use decodable codabele stuff to decode that data into an array of followers and then we are gonna return through success case of the result type, if not we will send an error
        do{
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favouritesData)
            completed(.success(favorites))
        } catch{
            completed(.failure(.unableToFavorite))
        }
    }
    
    // MARK: Saving array
    // When we are saving it we are encoding it.
    static func save(favorites: [Follower]) -> GFError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.setValue(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
}
