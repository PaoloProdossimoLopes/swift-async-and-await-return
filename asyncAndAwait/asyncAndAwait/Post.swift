//
//  Post.swift
//  asyncAndAwait
//
//  Created by Paolo Prodossimo Lopes on 27/03/22.
//

import Foundation

struct Post: Codable {
    let id: Int
    let title: String
    let body: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case body = "body"
    }
}
