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
    internal let endpointVersion: String = "v1"
    var baseURL: String { return "www.google.com" }
    
    var endpoints: Endpoints {
        return Endpoints(charactersList: "CharacterListResponse",
                         characterDetail: "CharacterDetailResponse"
        )
    }
    
    lazy var apiClient: APIClientProtocol = {
        return ApiMockClient(privateKey: "", apiKey: "")
    }()
    
    lazy var serverTrustManager: ServerTrustManager = {
        var base = ""
        if let hostBase = URL(string: baseURL)?.host { base = hostBase }
        return ServerTrustManager(allHostsMustBeEvaluated: true,
                                  evaluators: [base: DisabledEvaluator()])
    }()

}
