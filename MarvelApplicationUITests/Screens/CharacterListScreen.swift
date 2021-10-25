//
//  CharacterListScreen.swift
//  MarvelApplicationTests
//
//  Created by K3V1NS4N on 25/10/21.
//

class CharacterListScreen: UIScreenBase {
    
    static let screenTitle = navBars[Identifier.CharacterList.CharacterListTitle.rawValue]
    static let searchDescription = screenTitle.searchFields[Identifier.CharacterList.searchBarDescription.rawValue]
    static let searchCancelButton = screenTitle.buttons[Identifier.CharacterList.searchBarCancelButton.rawValue]
    static let characters = collectionView
    static let secondCell = collectionView.staticTexts[Identifier.CharacterList.secondCellName.rawValue]
    static let absorbingManCell = staticTexts[Identifier.CharacterList.absorbingMan.rawValue]
}
