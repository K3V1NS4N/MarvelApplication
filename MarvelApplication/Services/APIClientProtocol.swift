//
//  APIClientProtocol.swift
//  MarvelApplication
//
//  Created by K3V1NS4N on 20/10/21.
//

import Foundation

protocol APIClientProtocol {
    init(privateKey: String, apiKey: String)
    func request<T: Decodable>(from route: API, keyPath: String?, decoder: JSONDecoder, completion: (@escaping (_: Result<T, Error>) -> Void))
    
}

extension APIClientProtocol {
    func request<T: Decodable>(from route: API, keyPath: String? = nil, decoder: JSONDecoder = JSONDecoder(), completion: (@escaping (_: Result<T, Error>) -> Void)) {
        return request(from: route, keyPath: keyPath, decoder: decoder, completion: completion)
    }
}
