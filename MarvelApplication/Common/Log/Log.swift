//
//  Log.swift
//  MarvelApplication
//
//  Created by K3V1NS4N on 25/10/21.
//

import Foundation

func print(_ object: Any) {
    #if DEBUG
    Swift.print(object)
    #endif
}

class Log {

    class func d( _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        #if DEBUG
        print("\(Date())❕[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName) -> \(object)")
        #endif
    }
    
    private class func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : (components.last ?? "")
    }
}
