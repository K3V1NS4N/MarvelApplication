//
//  CharacterListRouter.swift
//  MarvelApplication
//
//  Created K3V1NS4N on 20/10/21.
//

import UIKit
protocol CharacterListRouterProtocol: AnyObject {
    func goToCharacterDetail(characterId: Int)
}

class CharacterListRouter: CharacterListRouterProtocol {

    weak var interactorToPresenter: CharacterListInteractorPresenterProtocol?
    weak var viewToPresenter: CharacterListViewPresenterProtocol?
    weak var viewController: CharacterListViewController?
    
    static func createModule() -> CharacterListViewController? {
        // Change to get view from storyboard if not using progammatic UI
        let view = CharacterListViewController(nibName: String(describing: CharacterListViewController.self), bundle: nil)
        let interactor = CharacterListInteractor(apiClient: EnvConfig.shared.apiClient)
        let router = CharacterListRouter()
        let presenter = CharacterListPresenter(interface: view, interactor: interactor, router: router)
        interactor.presenter = presenter
        view.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    func goToCharacterDetail(characterId: Int) {
        guard let characterDetail = CharacterDetailRouter.createModule(characterId: characterId) else {return}
        self.viewController?.navigationController?.pushViewController(characterDetail, animated: true)   
    }
}
