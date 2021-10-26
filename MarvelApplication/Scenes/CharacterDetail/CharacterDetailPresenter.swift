//
//  CharacterDetailPresenter.swift
//  MarvelApplication
//
//  Created K3V1NS4N on 20/10/21.
//

import UIKit

protocol CharacterDetailViewPresenterProtocol: AnyObject {
    func viewDidLoad()
    func getCharacterDetail()
}

protocol CharacterDetailInteractorPresenterProtocol: AnyObject {
    func didGetCharacterDetail(characterDetail: CharactersListModelResponse)
    func didGetCharacterDetailError(error: CharacterDetailError)
}

class CharacterDetailPresenter {
 
    var router: CharacterDetailRouterProtocol?
    var interactor: CharacterDetailInteractorProtocol?
    weak var view: CharacterDetailViewControllerProtocol?

    private var characterId: Int?
    
    init(interface: CharacterDetailViewControllerProtocol, interactor: CharacterDetailInteractorProtocol?, router: CharacterDetailRouterProtocol?, characterId: Int) {
        self.router = router
        self.interactor = interactor
        self.view = interface
        self.characterId = characterId
    }
    
    private func displayError() {
        
        self.view?.showError(title: CharacterDetailError.genericError(.genericServerError).title, description: CharacterDetailError.genericError(.genericServerError).description, icon: .serverErrorIcon)
    }

}

extension CharacterDetailPresenter: CharacterDetailViewPresenterProtocol {
    func viewDidLoad() {
        getCharacterDetail()
    }
    
    func getCharacterDetail() {
        guard let id = characterId else {
            return
        }

        // We could avoid this call to reduce number of call and increase performance, we already have the character object from the previous list
        self.interactor?.getCharacterDetail(characterId: id)
        
    }
}

extension CharacterDetailPresenter: CharacterDetailInteractorPresenterProtocol {
    func didGetCharacterDetail(characterDetail: CharactersListModelResponse) {
        guard let character = characterDetail?.data?.results?.first else {
            displayError()
            return
        }
        
        if let characterId = character.id, let name = character.name, let description = character.description, let imagePath = character.thumbnail?.path, let imageExt = character.thumbnail?.extension {
            
            let model = CharacterDetailViewModel(id: characterId, name: name, description: description, imagePath: imagePath, imageExt: ImageExt(rawValue: imageExt.rawValue) ?? .jpg)
            
            self.view?.displayCharacter(model: model)
        } else {
            displayError()
        }
         
    }
    
    func didGetCharacterDetailError(error: CharacterDetailError) {
        switch error {
        case .connection:
            self.view?.showError(title: error.title, description: error.description, icon: .connectionErrorIcon)
            return
        case .genericError:
            self.view?.showError(title: error.title, description: error.description, icon: .serverErrorIcon)
            return
        }
    }
}
