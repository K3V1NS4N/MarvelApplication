//
//  CharacterListViewModel.swift
//  MarvelApplication
//
//  Created by Kevin Sabajanes on 23/10/21.
//

import Foundation

public struct CharacterListViewModel {

    var characterList: [CharactersListModel.Hero] = []
    
    init(characterList: [CharactersListModel.Hero]) {
        self.characterList = characterList
    }
}
