//
//  User.swift
//  TribalTestApp
//
//  Created by Fernando Borges Paul on 28/11/20.
//

import Foundation

struct User: Decodable {
    let id: String
    let username: String
    let name: String?
    let first_name: String?
    let last_name: String?
    let bio: String?
    let profile_image: ProfileImage
    let location: String?
    let total_collections: Int
    let total_likes: Int
    let total_photos: Int
    
    struct ProfileImage: Decodable {
        let small: String
        let medium: String
        let large: String
    }
    
}



