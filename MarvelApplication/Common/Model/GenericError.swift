//
//  GenericError.swift
//  MarvelApplication
//
//  Created by K3V1NS4N on 20/10/21.
//

import Foundation

struct GenericError: Error, Codable {
    var statusCode: Int?
    let code: String?
    let message: String?
}
