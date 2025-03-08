//
//  Post.swift
//  Social-network
//
//  Created by Даша Николаева on 04.03.2025.
//

import Foundation

struct Post: Decodable {
    let id: Int
    let title: String
    let body: String
    var image: Data?
    var liked: Bool? = false
}
