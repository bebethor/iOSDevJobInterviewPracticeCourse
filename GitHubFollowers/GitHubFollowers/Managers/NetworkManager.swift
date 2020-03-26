//
//  NetworkManager.swift
//  GitHubFollowers
//
//  Created by Jose Alberto on 18/02/2020.
//  Copyright © 2020 JARCG. All rights reserved.
//

import UIKit

class NetworkManager {
    // Singleton
    static let shared           = NetworkManager() //  this information will be shared among all the instances
    private let baseURL         = "https://api.github.com/users/"
    let cache                   = NSCache<NSString, UIImage>()
    
    private init() {}
    
    // Get Followers list
    func getFollowers(for username: String, page: Int, completion: @escaping (Result<[Follower], GHFError>) -> Void) {
        let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidUserName))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            // Parse JSON
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completion(.success(followers))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    // Get user info
    // @escaping means that the completion can live out of getUserInfo. This is made for asynchronous operations
    func getUserInfo(for username: String, completion: @escaping (Result<User, GHFError>) -> Void) {
        let endpoint = baseURL + "\(username)"
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidUserName))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            // Parse JSON
            do {
                let decoder                     = JSONDecoder()
                decoder.keyDecodingStrategy     = .convertFromSnakeCase
                decoder.dateDecodingStrategy    = .iso8601
                let user                        = try decoder.decode(User.self, from: data)
                completion(.success(user))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    // Download avatar image. This function has to return nil or and UIImage
    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        // Check cache
        if let image = cache.object(forKey: cacheKey) {
            completion(image) // if the image is the cache, pass back the image in the completion closure
            return // exit from the downloadImage and don´t make the network call
        }
        
        // No handle errors because the placeholder image is like and error
        guard let url = URL(string: urlString) else {
            completion(nil) // if the url is bad there´s no image and so we pass back nil.
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self,
                error == nil,
                let response = response as? HTTPURLResponse, response.statusCode == 200,
                let data     = data,
                let image    = UIImage(data: data) else {
                    completion(nil)
                    return
                }
            
            self.cache.setObject(image, forKey: cacheKey)
            completion(image)
        }
        task.resume()
    }
}
