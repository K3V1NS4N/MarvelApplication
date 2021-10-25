//
//  String+Extension.swift
//  MarvelApplication
//
//  Created by K3V1NS4N on 22/10/21.
//

import Foundation

extension String {
    
    public var localized: String {
        return NSLocalizedString(self, comment: self)
    }
    
    // It returns an url with the hyper transfer protocol securized
    func securizePath() -> URL? {
        return URL(string: self.replacingOccurrences(of: "http://", with: "https://"))
    }
    
    // It inserts the extension provided at the end of the String
    func addExtension(ext: String) -> String {
        return String(self + "." + ext)
    }
}
