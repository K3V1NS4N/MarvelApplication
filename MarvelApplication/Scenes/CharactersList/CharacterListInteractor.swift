//
//  CharacterListInteractor.swift
//  MarvelApplication
//
//  Created K3V1NS4N on 20/10/21.s
//

import UIKit

protocol CharacterListInteractorProtocol: AnyObject {
    func getInitialCharacterList(name: String?)
    func getNextCharacters(offset: Int, name: String?)
}

class CharacterListInteractor: CharacterListInteractorProtocol, ReachabilityInteractor {
 
    weak var presenter: CharacterListInteractorPresenterProtocol?
    var apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
    func getInitialCharacterList(name: String? = nil) {
        guard isReachable else {
            self.presenter?.didGetCharacterListError(error: .connection(.notReachable))
            return
        }
        apiClient.request(from: API.charactersList(offset: 0, name: name)) { (result: Result<CharactersListModelResponse, Error>) in 
            switch result {
            case .success(let value):
                self.presenter?.didGetInitialCharacterList(characterList: value)
            case .failure:
                self.presenter?.didGetCharacterListError(error: .genericError(.genericServerError))
            }

        }
    }
    
    func getNextCharacters(offset: Int, name: String? = nil) {
        guard isReachable else {
            self.presenter?.didGetCharacterListError(error: .paginationConnectionError)
            return
        }
        apiClient.request(from: API.charactersList(offset: offset, name: name)) { (result: Result<CharactersListModelResponse, Error>) in
            switch result {
            case .success(let value):
                self.presenter?.didGetNextCharacterList(characterList: value)
            case .failure:
                self.presenter?.didGetCharacterListError(error: .paginationError)
            }

        }
    }

}
