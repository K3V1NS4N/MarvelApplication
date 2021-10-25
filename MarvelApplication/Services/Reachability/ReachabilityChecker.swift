//
//  ReachabilityChecker.swift
//  MarvelApplication
//
//  Created by K3V1NS4N on 21/10/21.
//

import Foundation

internal protocol ReachabilityInteractor {
    var isReachable: Bool { get }
}

internal extension ReachabilityInteractor {
    var isReachable: Bool {
        return API.isReachable
    }
}
