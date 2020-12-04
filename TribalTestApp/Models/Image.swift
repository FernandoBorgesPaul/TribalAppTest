//
//  Image.swift
//  TribalTestApp
//
//  Created by Fernando Borges Paul on 28/11/20.
//

import Foundation


struct Image: Decodable {
    let id: String
    let width: Int
    let height: Int
    let color: String
    let likes: Int
    let user: User
    let urls: URLS
    
    struct URLS: Decodable {
        let raw: String
        let full: String?
        let regular: String
        let small: String
        let thumb: String
    }
    
}
