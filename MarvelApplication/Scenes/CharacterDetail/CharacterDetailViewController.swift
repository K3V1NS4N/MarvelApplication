//
//  CharacterDetailViewController.swift
//  MarvelApplication
//
//  Created K3V1NS4N on 20/10/21.
//

import UIKit
import AlamofireImage

protocol CharacterDetailViewControllerProtocol: AnyObject {
    func displayCharacter(model: CharacterDetailViewModel)
    func showError(title: String, description: String, icon: UIImage)
}

class CharacterDetailViewController: UIViewController, CharacterDetailViewControllerProtocol {
    
    // MARK: @IBOutletsvar
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterDescription: UILabel!
    
    // MARK: Variables
    var presenter: CharacterDetailViewPresenterProtocol?
    
    // MARK: Life cycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
        setUpUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setUpUI() {
        self.imageContainerView.roundCorners(corners: [.allCorners], radius: 6)
        self.imageContainerView.backgroundColor = UIColor.gray.withAlphaComponent(0.25)
        self.characterImageView.roundCorners(corners: [.allCorners], radius: 5)
    }
    
    func displayCharacter(model: CharacterDetailViewModel) {

        toggleVisibility(isHidden: false)
        self.backgroundImageView.addBlur()
        
        let description = model.description
        let path = model.imagePath
        let ext = model.imageExt
        
        UIView.transition(with: self.view, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.characterName.text = model.name
            self.configureCharacterDescription(description: description)
            self.configureImage(imagePath: path, ext: ext)
        })
    
    }
    
    private func configureCharacterDescription(description: String) {
        if !description.isEmpty {
            self.characterDescription.text = description
        } else {
            self.characterDescription.text = "screen.character.detail.empty.description".localized
        }
    }
    
    private func configureImage(imagePath: String, ext: String) {
        let pathWithExtension = imagePath.addExtension(ext: ext)
        let securizedPath = pathWithExtension.securizePath()
        
        guard let securePath = securizedPath else {
            self.characterImageView.image = .notFoundIcon
            return
        }
        
        self.characterImageView.image = nil
        self.characterImageView.af.setImage(withURL: securePath,
                                            imageTransition: .crossDissolve(0.25),
                                            completion: { response in
            self.handleImageResponse(image: response.value)
        })
    }
    
    private func handleImageResponse(image: UIImage?) {
        if let image = image {
            self.characterImageView.image = image
            self.backgroundImageView.image = image
        } else {
            self.characterImageView.image = .notFoundIcon
            self.backgroundImageView.image = .notFoundIcon
        }
    }
    
    private func toggleVisibility(isHidden: Bool) {
        imageContainerView.isHidden = isHidden
        characterImageView.isHidden = isHidden
        backgroundImageView.isHidden = isHidden
        characterName.isHidden = isHidden
        characterDescription.isHidden = isHidden
    }
    
    // MARK: Error cases
    func showError(title: String, description: String, icon: UIImage) {
        toggleVisibility(isHidden: true)
        let parameters = MessageViewParams(title: title,
                                         message: description,
                                         buttonTitle: "reload.button.title".localized,
                                         icon: icon,
                                         completion: {
            self.presenter?.getCharacterDetail()
            
        })
        
        MessageViewManager.showView(from: self.view, params: parameters)
    }
    
}
