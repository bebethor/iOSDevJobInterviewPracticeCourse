//
//  GHFError.swift
//  GitHubFollowers
//
//  Created by Jose Alberto on 18/02/2020.
//  Copyright © 2020 JARCG. All rights reserved.
//

import Foundation

enum GHFError: String, Error {
    case invalidUserName    = "This username does not exist. Please try with another user name"
    case unableToComplete   = "Unable to complete request. Invalid URL"
    case invalidResponse    = "Invalid response from server"
    case invalidData        = "Invalid data received from server"
    case unableToFavorite   = "There was an error favoriting this user. Please try again."
    case alreadyFavorites   = "You´ve already favorited this user. You must REALLY like him!"
}
