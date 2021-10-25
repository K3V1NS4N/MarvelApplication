//
//  CharacterDetailViewModel.swift
//  MarvelApplication
//
//  Created by K3V1NS4N on 25/10/21.
//

public struct CharacterDetailViewModel {

    var character: CharactersListModel.Hero?
    
    init(character: CharactersListModel.Hero) {
        self.character = character
    }
}
