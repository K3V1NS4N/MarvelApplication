//
//  CharacterDetailInteractor.swift
//  MarvelApplication
//
//  Created K3V1NS4N on 20/10/21.s
//

import UIKit

protocol CharacterDetailInteractorProtocol: AnyObject {
    func getCharacterDetail(characterId: Int)
}

class CharacterDetailInteractor: CharacterDetailInteractorProtocol, ReachabilityInteractor {

    weak var presenter: CharacterDetailPresenterProtocol?
    
    var apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
    func getCharacterDetail(characterId: Int) {
        guard isReachable else {
            self.presenter?.didGetCharacterDetailError(error: .connection(.notReachable))
            return
        }
        apiClient.request(from: API.characterDetail(id: characterId)) { (result: Result<CharactersListModelResponse, Error>) in
            switch result {
            case .success(let value):
                self.presenter?.didGetCharacterDetail(characterDetail: value)
            case .failure:
                self.presenter?.didGetCharacterDetailError(error: .genericError(.genericServerError))
            }
            
        }
    }

}
