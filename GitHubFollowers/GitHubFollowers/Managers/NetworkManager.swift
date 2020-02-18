//
//  NetworkManager.swift
//  GitHubFollowers
//
//  Created by Jose Alberto on 18/02/2020.
//  Copyright © 2020 JARCG. All rights reserved.
//

import Foundation

class NetworkManager {
    // Singleton
    static let shared   = NetworkManager() //  this information will be shared among all the instances
    let baseURL         = "https://api.github.com/users"
    
    private init() {}
    
    func getFollowers(for username: String, page: Int, completion: @escaping ([Follower]?, String?) -> Void) {
        let endpoint = baseURL + "/users/\(username)/followers?per_page=100&page=\(page)"
        guard let url = URL(string: endpoint) else {
            completion(nil, "This username does not exist. Please try with another user name") // nil is for the followers array
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(nil, "Unable to complete request.")
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                
                return
            }
        }
        
        task.resume()
    }
}
