//
//  APIClient.swift
//  MarvelApplication
//
//  Created by K3V1NS4N on 20/10/21.
//

import Foundation
import Alamofire
import CodableAlamofire
import CryptoSwift

final class APIClient: APIClientProtocol {
    
    private var _privateKey: String
    private var _apiKey: String
    
    init(privateKey: String, apiKey: String) {
        _privateKey = privateKey
        _apiKey = apiKey
    }
    
    var privateKey: String { return _privateKey }
    var apiKey: String { return _apiKey }
    
    lazy var sessionManager: Session = {
        let configuration = URLSessionConfiguration.default
    
        configuration.headers = .default
        configuration.urlCache = nil
        configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        let trustManager = EnvConfig.shared.serverTrustManager
        return Session(configuration: configuration, serverTrustManager: trustManager)
    }()

    func request<T>(from route: API, keyPath: String? = nil, decoder: JSONDecoder = JSONDecoder(), completion: @escaping ((Result<T, Error>) -> Void)) where T: Decodable {
         
        assignKeys()
        sessionManager.request(route).responseDecodableObject(queue: .main, keyPath: keyPath, decoder: decoder) { [weak self] (response: DataResponse<T, AFError>) in

            if let httpBody = response.request?.httpBody {
                    print(String(decoding: (httpBody), as: UTF8.self))
                Log.d(String(decoding: (httpBody), as: UTF8.self))
            }

            print("response: \(String(describing: response.response))")
            Log.d("response: \(String(describing: response.response))")
            
            guard let resp = response.response,
                (200...300).contains(resp.statusCode) else {
                if let self = self {
                    completion(.failure(self.decodeError(statusCode: response.response?.statusCode, data: response.data, error: response.error)))
                } else {
                    completion(.failure(NSError()))
                }
                return
            }
            
            switch response.result {
            case .failure(let error):
                completion(Result.failure(error))
            case .success(let value):
                #if DEBUG
                if let data = response.data, let dataStr = String(data: data, encoding: .utf8) {
                    Log.d("response.data: \(dataStr))")
                }
                #endif
                completion(Result.success(value))
            }
        }
    }

    fileprivate func decodeError(statusCode: Int?, data: Data?, error: Error?) -> Error {
        
        if let data = data {
            var decodedData = try? JSONDecoder().decode(GenericError.self, from: data)
            
            Log.d("decodedError: \(String(describing: decodedData))")

            decodedData?.statusCode = statusCode
            
            if let errorModel = decodedData {
                return errorModel
            }
        }
        guard let error = error else {
            return NSError()
        }
        
        return error
    }
    
    private func assignKeys() {
        let timeStamp = "\(Date().timeIntervalSince1970)"
        API.timeStamp = timeStamp
        API.apiKey = apiKey
        API.hash = "\(timeStamp)\(privateKey)\(apiKey)".md5()
    }
    
}
