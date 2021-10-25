//
//  GenericApiError.swift
//  MarvelApplication
//
//  Created by K3V1NS4N on 21/10/21.
//

import Foundation
import Alamofire

internal enum GenericServerError {
    // MARK: Cases
    case genericServerError
    
}

extension GenericServerError: LocalizedError {
    
    internal var errorDescription: String? {
        switch self {
        case .genericServerError:
            return "api.generic.error.description".localized
        }
    }
    
}

internal extension GenericServerError {
    var title: String {
        switch self {
        case .genericServerError:
            return "api.generic.error.title".localized
        }
    }
    
    var description: String {
        return errorDescription ?? ""
    }
}
