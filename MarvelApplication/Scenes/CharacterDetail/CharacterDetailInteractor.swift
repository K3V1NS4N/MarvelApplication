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

    weak var presenter: CharacterDetailInteractorPresenterProtocol?
    
    var apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
    func getCharacterDetail(characterId: Int) {
        guard isReachable else {
            self.presenter?.didGetCharacterDetailError(error: .connection(.notReachable))
            return
        }
        apiClient.request(from: API.characterDetail(id: characterId)) { [weak self] (result: Result<CharactersListModelResponse, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let value):
                self.presenter?.didGetCharacterDetail(characterDetail: value)
            case .failure:
                self.presenter?.didGetCharacterDetailError(error: .genericError(.genericServerError))
            }
            
        }
    }

}
