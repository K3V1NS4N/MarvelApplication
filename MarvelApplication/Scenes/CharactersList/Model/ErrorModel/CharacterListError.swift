//
//  CharacterListError.swift
//  MarvelApplication
//
//  Created by K3V1NS4N on 21/10/21.
//

import Foundation

enum CharacterListError {

    // MARK: Cases
    case connection(_ value: ConnectionError)
    case genericError(_ value: GenericServerError)
    case paginationError
    case paginationConnectionError
    
    var title: String {
        switch self {
        case .connection(let error):
        return error.title
        case .genericError(let error):
            return error.title
        case .paginationError:
            return ""
        case .paginationConnectionError:
            return ""
        }
    }
    var description: String {
        switch self {
        case .connection(let error):
            return error.description
        case .genericError(let error):
            return error.description
        case .paginationError:
            return "screen.pagination.error.description".localized
        case .paginationConnectionError:
            return "screen.pagination.connection.error.description".localized
        }
    }
}
