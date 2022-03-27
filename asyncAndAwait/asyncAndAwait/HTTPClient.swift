//
//  HTTPClient.swift
//  asyncAndAwait
//
//  Created by Paolo Prodossimo Lopes on 27/03/22.
//

import Foundation

protocol HTTPClient {
    func sendRequest<T: Decodable>(
        endpoint: Endpoint, responseModel: T.Type
    ) async -> Result<T, RequestError>
}

extension HTTPClient {
    func sendRequest<T: Decodable>(
        endpoint: Endpoint,
        responseModel: T.Type
    ) async -> Result<T, RequestError> {
        guard let url = URL(string: endpoint.baseURL + endpoint.path)
        else { return .failure(.invalidURL) }
        
        var request = URLRequest(url: url)
        configureRequest(request: &request, endpoint: endpoint)
        
        return await handleRequest(request: request)
    }
    
    private func configureRequest(request: inout URLRequest, endpoint: Endpoint) {
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        
        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
    }
    
    private func handleRequest<T: Decodable>(request: URLRequest) async -> Result<T, RequestError> {
        do {
            let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
            
            guard let response = response as? HTTPURLResponse
            else { return .failure(.noResponse) }
            
            return await handleStatusCode(data: data, statusCode: response.statusCode)
        } catch {
            return .failure(.unknown)
        }
    }
    
    private func handleStatusCode<T: Decodable>(
        data: Data, statusCode: Int
    ) async -> Result<T, RequestError> {
        
        switch statusCode {
            case 200...299:
                let decoder = JSONDecoder()
                guard let decodedResponse = try? decoder.decode(T.self, from: data)
                else { return .failure(.decode) }
                return .success(decodedResponse)
            case 401: return .failure(.unauthorized)
            default: return .failure(.unexpectedStatusCode)
        }
    }
}
