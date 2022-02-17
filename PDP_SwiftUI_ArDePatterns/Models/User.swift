//
//  User.swift
//  PDP_SwiftUI_ArDePatterns
//


import Foundation

struct User: Decodable {
    
    var avatar_url: String?
    var name: String?
    var login: String?
    var bio: String?
    var blog: String?
    var followers: Int?
    var following: Int?
    
    enum CodingKeys: String, CodingKey {
        case avatar_url = "avatar_url"
        case login = "login"
        case bio = "bio"
        case name = "name"
        case blog = "blog"
        case followers = "followers"
        case following = "following"
    }
}
