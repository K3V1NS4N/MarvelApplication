//
//  ApiMockClient.swift
//  MarvelApplication
//
//  Created by K3V1NS4N on 20/10/21.
//

import Foundation
import Alamofire
import CodableAlamofire

// Api client for loading mockups
final class ApiMockClient: APIClientProtocol {
    
    init(privateKey: String, apiKey: String) {
    }
    
    func request<T>(from route: API, keyPath: String? = nil, decoder: JSONDecoder = JSONDecoder(), completion: @escaping ((Result<T, Error>) -> Void)) where T: Decodable {

        do {
            // We decode the json file based on the path provided
            if let bundlePath = Bundle.main.path(forResource: route.path, ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                let decodedData = try decoder.decode(T.self, from: jsonData)
                completion(Result.success(decodedData))
            } else {
                completion(Result.failure(NSError()))
            }
        } catch let error {
            completion(Result.failure(error))
        }
    }

}
