//
//  PersistanceManager.swift
//  GitHubFollowers
//
//  Created by Jose Alberto Ruíz-Carrillo González on 12/03/2020.
//  Copyright © 2020 JARCG. All rights reserved.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistanceManager {
    
    static private let defaults = UserDefaults.standard
    
    enum keys {
        static let favorites = "favorites"
    }
    
    static func updateWith(favorite: Follower, actionType: PersistenceActionType, completion: @escaping(GHFError?) -> Void ) {
        // Recuperar favoritos del userDefaults
        retrieveFavorites { ( result ) in
            // Evaluamos
            switch result {
            case .success(var favorites):
                switch actionType {
                // En el caso succes, añadidos o borramos
                case .add:
                    guard !favorites.contains(favorite) else {
                        completion(.alreadyFavorites)
                        return
                    }
                    favorites.append(favorite)
                case .remove:
                    favorites.removeAll { $0.login == favorite.login }
                }
                completion(save(favorites: favorites))
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    // Devuelve el array de favoritos (decodifica) de userDefaults
    static func retrieveFavorites(completed: @escaping (Result<[Follower], GHFError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: keys.favorites) as? Data else {
            // En caso de que favoritesData sea "nil" es por que nunca se ha guardado nada en "favoritesData" antes. En ese caso se devuelve un array vacio en el succes.
            completed(.success([]))
            return
        }
        
        // Decode Data
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableToFavorite))
        }
    }
    
    static func save(favorites: [Follower]) -> GHFError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
}
