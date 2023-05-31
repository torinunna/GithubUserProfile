//
//  UserProfile.swift
//  GithubUserProfile
//
//  Created by YUJIN KWON on 2023/05/31.
//

import Foundation

struct UserProfile: Hashable, Identifiable, Codable {
    
    var id: Int64
    var login: String
    var name: String
    var avatarUrl: URL
    var htmlUrl: String
    var followers: Int
    var following: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case login
        case avatarUrl = "avatar_url"
        case htmlUrl = "html_url"
        case followers
        case following
    }
}
