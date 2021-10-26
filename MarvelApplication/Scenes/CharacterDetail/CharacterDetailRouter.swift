//
//  CharacterDetailRouter.swift
//  MarvelApplication
//
//  Created K3V1NS4N on 20/10/21.
//

import UIKit
protocol CharacterDetailRouterProtocol: AnyObject {

}

class CharacterDetailRouter: CharacterDetailRouterProtocol {
    
    weak var interactorToPresenter: CharacterDetailInteractorPresenterProtocol?
    weak var viewToPresenter: CharacterDetailViewPresenterProtocol?
    weak var viewController: CharacterDetailViewController?
    
    static func createModule(characterId: Int) -> CharacterDetailViewController? {
        // Change to get view from storyboard if not using progammatic UI
        let view = CharacterDetailViewController(nibName: String(describing: CharacterDetailViewController.self), bundle: nil)
        let interactor = CharacterDetailInteractor(apiClient: EnvConfig.shared.apiClient)
        let router = CharacterDetailRouter()
        let presenter = CharacterDetailPresenter(interface: view, interactor: interactor, router: router, characterId: characterId)
        interactor.presenter = presenter
        view.presenter = presenter
        router.viewController = view
        
        return view
    }
}
