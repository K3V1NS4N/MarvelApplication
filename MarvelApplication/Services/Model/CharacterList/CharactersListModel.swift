//
//  CharactersListModel.swift
//  MarvelApplication
//
//  Created by K3V1NS4N on 21/10/21.
//

import Foundation
typealias CharactersListModelResponse = CharactersListModel.CharacterResponse?
public typealias CharacterModel = CharactersListModel.Hero?
public struct CharactersListModel: Codable {
    
    // MARK: - CharacterResponse
    struct CharacterResponse: Codable {
        let code: Int?
        let status, copyright, attributionText, attributionHTML: String?
        let etag: String?
        let data: DataClass?
    }
    
    // MARK: - DataClass
    struct DataClass: Codable {
        let offset, limit, total, count: Int?
        let results: [Hero]?
    }
    
    // MARK: - Character
    public struct Hero: Codable {
        let id: Int?
        let name: String?
        let description: String?
        let thumbnail: Thumbnail?
        let resourceURI: String?
        let comics, series: Comics?
        let stories: Stories?
        let events: Comics?
        let urls: [URLElement]?
    }
    
    // MARK: - Comics
    struct Comics: Codable {
        let available: Int?
        let collectionURI: String?
        let items: [ComicsItem]?
        let returned: Int?
    }
    
    // MARK: - ComicsItem
    struct ComicsItem: Codable {
        let resourceURI: String?
        let name: String?
    }
    
    // MARK: - Stories
    struct Stories: Codable {
        let available: Int?
        let collectionURI: String?
        let items: [StoriesItem]?
        let returned: Int
    }
    
    // MARK: - StoriesItem
    struct StoriesItem: Codable {
        let resourceURI: String?
        let name: String?
    }
    
    // MARK: - Thumbnail
    struct Thumbnail: Codable {
        var path: String?
        let `extension`: Extension?
    }
    
    enum Extension: String, Codable {
        case gif
        case jpg
        case png
    }
    
    // MARK: - URLElement
    struct URLElement: Codable {
        let url: String?
    }

}
