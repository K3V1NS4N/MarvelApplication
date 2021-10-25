//
//  CharacterDetailModelTest.swift
//  MarvelApplicationTests
//
//  Created by K3V1NS4N on 25/10/21.
//

import Foundation

class CharacterDetailModelTest {
    func nilCase() -> CharactersListModelResponse {
        return CharactersListModel.CharacterResponse(code: nil, status: nil, copyright: nil, attributionText: nil, attributionHTML: nil, etag: nil, data: nil)
    }
    
    func fillCase() -> CharactersListModelResponse {
        
        let character1 = CharactersListModel.Hero(id: 1011334, name: "3-D Man", description: "", thumbnail: CharactersListModel.Thumbnail(path: "test", extension: .jpg), resourceURI: nil, comics: nil, series: nil, stories: nil, events: nil, urls: nil)
        
        let results: [CharactersListModel.Hero] = [character1]
        
        let data = CharactersListModel.DataClass(offset: 0, limit: 20, total: 1559, count: 20, results: results)
        
        return CharactersListModel.CharacterResponse(code: 200, status: "Ok", copyright: "© 2021 MARVEL", attributionText: "Data provided by Marvel. © 2021 MARVEL", attributionHTML: "test", etag: "test", data: data)
    }

}
