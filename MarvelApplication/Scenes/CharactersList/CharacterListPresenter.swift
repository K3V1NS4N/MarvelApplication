//
//  CharacterListPresenter.swift
//  MarvelApplication
//
//  Created K3V1NS4N on 20/10/21.
//

import UIKit

protocol CharacterListPresenterProtocol: AnyObject {
    func viewDidLoad()
    func getInitialCharacterList()
    func didGetInitialCharacterList(characterList: CharactersListModelResponse)
    func didGetNextCharacterList(characterList: CharactersListModelResponse)
    func didGetCharacterListError(error: CharacterListError)
    func didTapOnCharacter(characterID: Int?)
    func scrollViewDidReachEnd()
    func didPerformedSearch(name: String)
}

class CharacterListPresenter: CharacterListPresenterProtocol {

    var router: CharacterListRouterProtocol?
    var interactor: CharacterListInteractorProtocol?
    weak var view: CharacterListViewControllerProtocol?
    
    private var loadingMoreCharacters = false
    private var offset = 0
    private var name: String?
    
    init(interface: CharacterListViewControllerProtocol, interactor: CharacterListInteractorProtocol?, router: CharacterListRouterProtocol?) {
        self.router = router
        self.interactor = interactor
        self.view = interface
    }
    
    func viewDidLoad() {
        getInitialCharacterList()
    }
    
    func getInitialCharacterList() {
        loadingMoreCharacters = true
        name = nil
        offset = 0
        self.interactor?.getInitialCharacterList(name: nil)
    }
    
    func didGetInitialCharacterList(characterList: CharactersListModelResponse) {
        guard let characters = characterList?.data?.results else {
            self.view?.showMessage(title: CharacterListError.genericError(.genericServerError).title,
                                 description: CharacterListError.genericError(.genericServerError).description,
                                 icon: .serverErrorIcon)
            return
        }
        if characters.isEmpty {
            self.view?.showMessage(title: "screen.character.list.no.results.title".localized,
                                   description: "screen.character.list.no.results.description".localized,
                                   icon: .infoIcon)
            return
        }
                
        let viewModel = retrieveCharacterCells(characters: characters)
        self.view?.displayInitialCharacterList(characterList: viewModel)
        loadingMoreCharacters = false
    }
    
    func didGetNextCharacterList(characterList: CharactersListModelResponse) {

        guard let characters = characterList?.data?.results else {
            self.view?.showPaginationMessage(description: CharacterListError.paginationError.description)
            return
        }
        if characters.isEmpty {
            self.view?.showPaginationMessage(description: "screen.character.list.pagination.no.results".localized)
            return
        }
        
        let viewModel = retrieveCharacterCells(characters: characters)
        self.view?.displayNextCharacterList(characterList: viewModel)
        self.loadingMoreCharacters = false
    }
    
    func didTapOnCharacter(characterID: Int?) {
        guard let id = characterID else { return }
        self.router?.goToCharacterDetail(characterId: id)
    }
    
    func didGetCharacterListError(error: CharacterListError) {
        switch error {
        case .connection:
            self.view?.showMessage(title: error.title, description: error.description, icon: .connectionErrorIcon)
            return
        case .genericError:
            self.view?.showMessage(title: error.title, description: error.description, icon: .serverErrorIcon)
            return
        case .paginationError:
            self.view?.showPaginationMessage(description: error.description)
            resetPaginationFailed()
            return
        case .paginationConnectionError:
            self.view?.showPaginationMessage(description: error.description)
            resetPaginationFailed()
            return
        }
    }
    
    private func retrieveCharacterCells(characters: [CharactersListModel.Hero]) -> CharacterListViewModel {
        
        var listOfCells: [CharacterCellModel] = []
        for character in characters {
            if let characterId = character.id, let name = character.name {
                listOfCells.append(CharacterCellModel(id: characterId, name: name, imagePath: character.thumbnail?.path, imageExt: ImageExt(rawValue: character.thumbnail?.extension?.rawValue ?? "")))
            }
        }
        return CharacterListViewModel(characterList: listOfCells)
    }
    
    private func resetPaginationFailed() {
        loadingMoreCharacters = false
        offset -= 20
    }
    
    func scrollViewDidReachEnd() {
        if !loadingMoreCharacters {
            self.view?.displayFooterLoader()
            offset += 20
            self.loadingMoreCharacters = true
            self.interactor?.getNextCharacters(offset: offset, name: name)
        }
    }
    
    func didPerformedSearch(name: String) {
        self.name = name
        self.interactor?.getInitialCharacterList(name: name)
    }
}



//EXTENSION
