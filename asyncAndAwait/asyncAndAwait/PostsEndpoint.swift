//
//  PostsEndpoint.swift
//  asyncAndAwait
//
//  Created by Paolo Prodossimo Lopes on 27/03/22.
//

import Foundation

struct PostsEndpoint: Endpoint {
    
    var baseURL: String {
        return "https://jsonplaceholder.typicode.com/posts"
    }
    
    var path: String {
//            switch self {
//            case .topRated:
//                return "movie/top_rated"
//            case .movieDetail(let id):
//                return "movie/\(id)"
//            }
        return ""
        }

        var method: RequestMethod {
//            switch self {
//            case .topRated, .movieDetail:
//                return .get
//            }
            return .get
        }

        var header: [String: String]? {
//            // Access Token to use in Bearer header
//            let accessToken = "Your TMDB Access Token here!!!!!!!"
//            switch self {
//            case .topRated, .movieDetail:
//                return [
//                    "Authorization": "Bearer \(accessToken)",
//                    "Content-Type": "application/json;charset=utf-8"
//                ]
//            }
            return nil
        }
        
        var body: [String: String]? {
//            switch self {
//            case .topRated, .movieDetail: return nil
//            }
            return nil
        }
}
