//
//  EnvProtocol.swift
//  MarvelApplication
//
//  Created by K3V1NS4N on 20/10/21.
//

import Foundation
import Alamofire

internal struct Endpoints {
    var charactersList: String
    var characterDetail: String
}

internal protocol EnvProtocol {
    var baseURL: String { get }
    var endpoints: Endpoints { get }
    var endpointVersion: String { get }
    var apiClient: APIClientProtocol { mutating get }
    var serverTrustManager: ServerTrustManager { mutating get }
}
