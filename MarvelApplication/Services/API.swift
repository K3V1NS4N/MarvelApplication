//
//  APIRouter.swift
//  MarvelApplication
//
//  Created by K3V1NS4N on 20/10/21.
//

import Foundation
import Alamofire

enum API: URLRequestConvertible {

    static var timeStamp: String?
    static var apiKey: String?
    static var hash: String?
    
    // MARK: Home
    case charactersList(offset: Int, name: String? = nil)
    case characterDetail(id: Int)
    
    // MARK: HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .charactersList, .characterDetail:
            return .get
        }
    }
    // MARK: EndPoint
    var path: String {
        switch self {
        case .charactersList:
            return String(format: EnvConfig.shared.endpoints.charactersList)
        case .characterDetail(let id):
            return String(format: EnvConfig.shared.endpoints.characterDetail, String(id))
        }
    }
    // MARK: Headers
    var headers: [String: String] {
        let headers: [String: String] = [:]
        return headers
    }
    
    // MARK: queryParameters
    var queryParameters: [String: Any]? {
        var params: [String: Any] = [:]
        if let timeStamp = API.timeStamp {
            params["ts"] = timeStamp
        }
        if let hash = API.hash {
            params["hash"] = hash
        }
        if let apiKey = API.apiKey {
            params["apikey"] = apiKey
        }
        switch self {
            
        case .charactersList(let offset, let name):
            params["offset"] = offset
            if let name = name {
                params["nameStartsWith"] = name
            }
            return params
        case .characterDetail:
            return params
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try EnvConfig.shared.baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))

        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
                
        switch self {
        // URL with Query Parameters
        case .charactersList, .characterDetail:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: queryParameters)
        }
        
        return urlRequest
    }

    static var isReachable: Bool {
        return NetworkReachabilityManager(host: EnvConfig.shared.baseURL)?.isReachable ?? false
    }
    
}

struct DictionaryEncoder {
    static func encode<T>(_ value: T) throws -> [String: Any] where T: Encodable {
        let jsonData = try JSONEncoder().encode(value)
        return try JSONSerialization.jsonObject(with: jsonData) as? [String: Any] ?? [:]
    }
}
