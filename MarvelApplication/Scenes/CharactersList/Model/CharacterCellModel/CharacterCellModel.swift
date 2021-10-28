//
//  CharacterCellModel.swift
//  MarvelApplication
//
//  Created by K3V1NS4N on 26/10/21.
//

import Foundation

public struct CharacterCellModel {
    
    let id: Int
    let name: String
    var imagePath: String
    let imageExt: String
    
    internal init(id: Int, name: String, imagePath: String, imageExt: String) {
        self.id = id
        self.name = name
        self.imagePath = imagePath
        self.imageExt = imageExt
    }
    
}
