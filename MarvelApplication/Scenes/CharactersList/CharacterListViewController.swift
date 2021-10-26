//
//  CharacterListViewController.swift
//  MarvelApplication
//
//  Created K3V1NS4N on 20/10/21.
//

import UIKit

protocol CharacterListViewControllerProtocol: AnyObject {
    func displayInitialCharacterList(characterList: CharacterListViewModel)
    func displayNextCharacterList(characterList: CharacterListViewModel)
    func showMessage(title: String, description: String, icon: UIImage)
    func showPaginationMessage(description: String)
    func displayFooterLoader()
}

class CharacterListViewController: UIViewController, CharacterListViewControllerProtocol {
  
    // MARK: @IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Variables
    var presenter: CharacterListPresenterProtocol?
    private let cellId = "cellId"
    private let headerId = "headerId"
    private let footerId = "footerId"
    private var viewModel: CharacterListViewModel?
    private var footer: CharacterFooterCell?
    private lazy var reloadButton: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh, target: self, action: #selector(didTapReload))
    }()
    private lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.placeholder = "screen.character.list.searchBar.placeholder".localized
        return controller
    }()

    // MARK: Life cycle functions
	override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        presenter?.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func setUpUI() {
        self.title = "screen.character.list.title".localized
        configureLoader()
        configureSearchBar()
        configureCollectionView()
    }
    
    // MARK: Loader
    private func configureLoader() {
        self.activityIndicator.color = UIColor.darkGray
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.startAnimating()
    }
    
    // MARK: Search Bar
    
    private func showReloadButton() {
        navigationItem.rightBarButtonItems = [reloadButton]
    }
    
    private func configureSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }
    
    // MARK: Reload NavBar button
    @objc func didTapReload() {
        navigationItem.rightBarButtonItems = nil
        self.activityIndicator.startAnimating()
        self.collectionView.isHidden = true
        self.presenter?.getInitialCharacterList()
    }
    
    // MARK: Collection view
    private func configureCollectionView() {
        // Register reusable cell
        collectionView.register(UINib(nibName: String(describing: CharacterCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: CharacterCell.self))
        // Register header cell
        collectionView?.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        // Register footer cell
        collectionView.register(CharacterFooterCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: CharacterFooterCell.identifier)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    func displayInitialCharacterList(characterList: CharacterListViewModel) {
        self.activityIndicator.stopAnimating()
        self.viewModel = characterList
        self.collectionView.reloadData()
        self.collectionView.isHidden = false
    }
    
    func displayNextCharacterList(characterList: CharacterListViewModel) {
        self.footer?.stopLoading()
        self.viewModel?.characterList.append(contentsOf: characterList.characterList)
        self.collectionView.reloadData()
    }
    
    func displayFooterLoader() {
        self.footer?.startLoading()
    }
    
    // MARK: Error cases
    func showMessage(title: String, description: String, icon: UIImage) {
        self.collectionView.isHidden = true
        self.activityIndicator.stopAnimating()
        let parameters = MessageViewParams(title: title,
                                         message: description,
                                         buttonTitle: "reload.button.title".localized,
                                         icon: icon,
                                         completion: {
            self.activityIndicator.startAnimating()
            self.navigationItem.rightBarButtonItems = nil
            self.presenter?.getInitialCharacterList()
            
        })
        
        MessageViewManager.showView(from: self.view, params: parameters)
    }
    
    func showPaginationMessage(description: String) {
        self.footer?.stopLoading()
        self.footer?.showMessage(description: description)
    }

}

// MARK: UICollectionViewDelegate
extension CharacterListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let numOfCharacters = viewModel?.characterList.count else {
            return 0
        }
        return numOfCharacters
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CharacterCell.self), for: indexPath) as? CharacterCell {
            
            guard let characters = viewModel?.characterList else {
                return UICollectionViewCell()
            }
            
            let character = characters[indexPath.row]
            cell.configure(model: character)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let character = viewModel?.characterList[indexPath.row] else {
            return
        }
        self.presenter?.didTapOnCharacter(characterID: character.id)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = view.frame.size.width
        // Any cell will take up 46% of the device with
        let size: CGFloat = 0.46
        return CGSize(width: width * size, height: width * size)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y + 1) >= (scrollView.contentSize.height - scrollView.frame.size.height) {
            self.presenter?.scrollViewDidReachEnd()
        }
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
            return header
        }

        guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: CharacterFooterCell.identifier, for: indexPath) as? CharacterFooterCell else {
            return UICollectionReusableView()
        }
        self.footer = footer
        footer.configure()
        return footer
    }
    
}
// MARK: UISearchBarDelegate
extension CharacterListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        self.collectionView.isHidden = true
        self.activityIndicator.startAnimating()
        self.searchController.isActive = false
        showReloadButton()
        self.presenter?.didPerformedSearch(name: text)
        
    }
    
}
