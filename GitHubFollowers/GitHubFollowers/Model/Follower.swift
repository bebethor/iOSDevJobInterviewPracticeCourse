//
//  Follower.swift
//  GitHubFollowers
//
//  Created by Jose Alberto on 18/02/2020.
//  Copyright © 2020 JARCG. All rights reserved.
//

import Foundation

struct Follower: Codable, Hashable {
    var login: String // user name
    var avatarUrl: String
}
