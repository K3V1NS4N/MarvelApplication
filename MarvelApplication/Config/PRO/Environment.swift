//
//  Environment.swift
//  MarvelApplication
//
//  Created by K3V1NS4N on 20/10/21.
//

import Foundation
import Alamofire

internal struct EnvConfig: EnvProtocol {
    
    static var shared = EnvConfig()
    private var environmentName: String = "MOCK"
    let endpointVersion: String = "v1"
    var baseURL: String { return "https://gateway.marvel.com" }
    private let privateKey: String = "ff2916a3ea0b465e7354ed4b88ad39a11531727e"
    private let apiKey: String = "ed2b67c8042ec9be7c350fd8ccee1f05"
    
    var endpoints: Endpoints {
        return Endpoints(charactersList: "/\(endpointVersion)/public/characters",
                         characterDetail: "/\(endpointVersion)/public/characters/%@"
        )
    }
    
    lazy var apiClient: APIClientProtocol = {
        return APIClient(privateKey: privateKey, apiKey: apiKey)
    }()
    
    lazy var serverTrustManager: ServerTrustManager = {
        var base = ""
        if let hostBase = URL(string: baseURL)?.host { base = hostBase }
        return ServerTrustManager(allHostsMustBeEvaluated: true,
                                  evaluators: [base: DefaultTrustEvaluator()])
    }()

}
