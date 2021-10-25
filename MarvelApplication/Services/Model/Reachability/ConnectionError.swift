//
//  ConnectionError.swift
//  MarvelApplication
//
//  Created by K3V1NS4N on 21/10/21.
//

import Foundation
import Alamofire

internal enum ConnectionError {
    case notReachable
    
}

extension ConnectionError: LocalizedError {
    
    internal var errorDescription: String? {
        switch self {
        case .notReachable:
            return "api.conection.error.description".localized
        }
    }
    
}
internal extension ConnectionError {
    var title: String {
        switch self {
        case .notReachable:
            return "api.conection.error.title".localized
        }
    }
    
    var description: String {
        return errorDescription ?? ""
    }
}
