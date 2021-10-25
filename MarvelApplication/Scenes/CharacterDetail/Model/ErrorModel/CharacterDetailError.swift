//
//  CharacterDetailError.swift
//  MarvelApplication
//
//  Created by K3V1NS4N on 24/10/21.
//

import Foundation

enum CharacterDetailError {

    // MARK: Cases
    case connection(_ value: ConnectionError)
    case genericError(_ value: GenericServerError)
    
    var title: String {
        switch self {
        case .connection(let error):
        return error.title
        case .genericError(let error):
            return error.title
        }
    }
    var description: String {
        switch self {
        case .connection(let error):
            return error.description
        case .genericError(let error):
            return error.description
        }
    }
}
