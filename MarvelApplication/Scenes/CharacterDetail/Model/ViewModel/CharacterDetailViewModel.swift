//
//  CharacterDetailViewModel.swift
//  MarvelApplication
//
//  Created by K3V1NS4N on 25/10/21.
//

public struct CharacterDetailViewModel {
    
    let id: Int
    let name: String
    let description: String
    var imagePath: String
    let imageExt: String
    
    internal init(id: Int, name: String, description: String, imagePath: String, imageExt: String) {
        self.id = id
        self.name = name
        self.description = description
        self.imagePath = imagePath
        self.imageExt = imageExt
    }
    
}
