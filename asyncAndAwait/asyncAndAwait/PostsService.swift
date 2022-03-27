//
//  PostsService.swift
//  asyncAndAwait
//
//  Created by Paolo Prodossimo Lopes on 27/03/22.
//

import Foundation

protocol PostsServiceProtocol {
    func fetchPosts() async -> Result<[Post], RequestError>
}

final class PostsService: HTTPClient, PostsServiceProtocol {
    
    func fetchPosts() async -> Result<[Post], RequestError> {
        let endpoint = PostsEndpoint()
        return await sendRequest(endpoint: endpoint, responseModel: [Post].self)
    }
    
}
