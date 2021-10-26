//
//  CharacterListViewModel.swift
//  MarvelApplication
//
//  Created by Kevin Sabajanes on 23/10/21.
//

import Foundation

struct CharacterListViewModel {

    var characterList: [CharacterCellModel] = []
    
    init(characterList: [CharacterCellModel]) {
        self.characterList = characterList
    }
}
