//
//  GHFImageView.swift
//  GitHubFollowers
//
//  Created by Jose Alberto on 19/02/2020.
//  Copyright © 2020 JARCG. All rights reserved.
//

import UIKit

class GHFImageView: UIImageView {
    
    let placeHolderImage = UIImage(named: "avatar-placeholder")!
    let cache = NetworkManager.shared.cache
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Custom code here
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius  = 10
        clipsToBounds       = true
        image               = placeHolderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downLoadImage(from urlString: String) {
        let cacheKey = NSString(string: urlString)
        
        // Check cache
        if let image = cache.object(forKey: cacheKey) {
            self.image = image
            return
        }
        
        // No handle errors because the placeholder image is like and error
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            if error != nil { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{ return }
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            self.cache.setObject(image, forKey: cacheKey)
            DispatchQueue.main.async { self.image = image }
        }
        task.resume()
    }
}
