//
//  ErrorMessage.swift
//  GitHubFollowers
//
//  Created by Jose Alberto on 18/02/2020.
//  Copyright © 2020 JARCG. All rights reserved.
//

import Foundation

enum ErrorMessage: String {
    case invalidUserName = "This username does not exist. Please try with another user name"
    case unableToComplete = "Unable to complete request. Invalid URL"
    case invalidResponse = "Invalid response from server"
    case invalidData = "Invalid data received from server"
}
