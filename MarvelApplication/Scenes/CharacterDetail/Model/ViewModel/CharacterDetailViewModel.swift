//
//  CharacterDetailViewModel.swift
//  MarvelApplication
//
//  Created by K3V1NS4N on 25/10/21.
//

public struct CharacterDetailViewModel {
    
    let id: Int?
    let name: String?
    let description: String?
    var imagePath: String?
    let imageExt: ImageExt?
    
    
    internal init(id: Int, name: String, description: String, imagePath: String, imageExt: ImageExt) {
        self.id = id
        self.name = name
        self.description = description
        self.imagePath = imagePath
        self.imageExt = imageExt
    }
    
}
