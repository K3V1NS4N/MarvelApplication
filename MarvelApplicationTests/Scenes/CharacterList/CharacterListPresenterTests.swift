//
//  CharacterListPresenterTests.swift
//  MarvelApplicationTests
//
//  Created by K3V1NS4N on 25/10/21.
//

import Foundation
import XCTest

@testable import MarvelApplication

class CharacterListPresenterTests: XCTestCase {
    private var sut: CharacterListPresenter!

    // MARK: - Test Objects
    private var interactorMock: MockCharacterListInteractorToPresenter!
    private var viewMock: MockCharacterListViewToPresenter!
    private var routerMock: MockCharacterListRouterToPresenter!
    
    override func setUp() {
        super.setUp()

        let router = MockCharacterListRouterToPresenter()
        self.routerMock = router
        let interactor = MockCharacterListInteractorToPresenter()
        self.interactorMock =  interactor
        let view = MockCharacterListViewToPresenter()
        self.viewMock = view

        sut = CharacterListPresenter(interface: view, interactor: interactor, router: router)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: Test Functions
    func testPresenterConnections() {
        XCTAssertNotNil(self.sut?.router)
        XCTAssertNotNil(self.sut?.interactor)
        XCTAssertNotNil(self.sut?.view)
    }
    
    func testViewDidLoad() {
        // Given
        // When
        self.sut.viewDidLoad()
        // Then
        XCTAssertTrue(interactorMock.didCallGetInitialCharacterList)
    }
    
    func testGetInitialCharacterList() {
        // Given
        // When
        self.sut.getInitialCharacterList()
        // Then
        XCTAssertTrue(interactorMock.didCallGetInitialCharacterList)
        
    }
    
    func testDidGetInitialCharacterList() {
        // Given
        let model = CharacterListModelTest().fillCase()
        // When
        sut.didGetInitialCharacterList(characterList: model)
        // Then
        XCTAssertTrue(viewMock.didDisplayInitialCharacterList)
    }
    
    func testDidGetInitialCharacterListNilModel() {
        // Given
        let model = CharacterListModelTest().nilCase()
        let titleError = CharacterListError.genericError(.genericServerError).title
        let descriptionError = CharacterListError.genericError(.genericServerError).description
        let iconError: UIImage = .serverErrorIcon
        
        // When
        sut.didGetInitialCharacterList(characterList: model)
        // Then
        XCTAssertFalse(viewMock.didDisplayInitialCharacterList)
        XCTAssertEqual(viewMock.showErrorTitle, titleError)
        XCTAssertEqual(viewMock.showErrordescription, descriptionError)
        XCTAssertEqual(viewMock.showErrorIcon, iconError)
    }

    func testDidGetNextCharacterList() {
        // Given
        let model = CharacterListModelTest().fillCase()
        // When
        sut.didGetNextCharacterList(characterList: model)
        // Then
        XCTAssertTrue(viewMock.didDisplayNextCharacterList)
    }
    
    func testDidGetNextCharacterListNilModel() {
        // Given
        let model = CharacterListModelTest().nilCase()
        let descriptionError = CharacterListError.paginationError.description
        // When
        sut.didGetNextCharacterList(characterList: model)
        // Then
        XCTAssertFalse(viewMock.didDisplayNextCharacterList)
        XCTAssertEqual(viewMock.showPaginationErrordescription, descriptionError)
        
    }
    
    // Pagination END
    func testDidGetNextCharacterListEmptyCharacter() {
        // Given
        let model = CharacterListModelTest().emptyCharacters()
        let descriptionError = "screen.character.list.pagination.no.results".localized
        // When
        sut.didGetNextCharacterList(characterList: model)
        // Then
        XCTAssertFalse(viewMock.didDisplayNextCharacterList)
        XCTAssertEqual(viewMock.showPaginationErrordescription, descriptionError)
        
    }
    
    func testDidTapOnCharacter() {
        // Given
        let characterID = 65434
        // When
        sut.didTapOnCharacter(characterID: characterID)
        // Then
        XCTAssertTrue(routerMock.didGoToCharacterDetail)
    }
    func testDidTapOnCharacterNullId() {
        // Given
        // When
        sut.didTapOnCharacter(characterID: nil)
        // Then
        XCTAssertFalse(routerMock.didGoToCharacterDetail)
    }
    
    func testDidGetCharacterListConnectionError() {
        // Given
        let error: CharacterListError = .connection(.notReachable)
        let titleError = CharacterListError.connection(.notReachable).title
        let descriptionError = CharacterListError.connection(.notReachable).description
        let iconError: UIImage = .connectionErrorIcon
        // When
        sut.didGetCharacterListError(error: error)
        // Then
        XCTAssertTrue(viewMock.didCallShowMessage)
        XCTAssertEqual(viewMock.showErrorTitle, titleError)
        XCTAssertEqual(viewMock.showErrordescription, descriptionError)
        XCTAssertEqual(viewMock.showErrorIcon, iconError)
        
    }
    
    func testDidGetCharacterListGenericError() {
        // Given
        let error: CharacterListError = .genericError(.genericServerError)
        let titleError = CharacterListError.genericError(.genericServerError).title
        let descriptionError = CharacterListError.genericError(.genericServerError).description
        let iconError: UIImage = .serverErrorIcon
        // When
        sut.didGetCharacterListError(error: error)
        // Then
        XCTAssertTrue(viewMock.didCallShowMessage)
        XCTAssertEqual(viewMock.showErrorTitle, titleError)
        XCTAssertEqual(viewMock.showErrordescription, descriptionError)
        XCTAssertEqual(viewMock.showErrorIcon, iconError)
    }
    
    func testDidGetCharacterListPaginationError() {
        // Given
        let error: CharacterListError = .paginationConnectionError
        let descriptionError = CharacterListError.paginationConnectionError.description
        // When
        sut.didGetCharacterListError(error: error)
        // Then
        XCTAssertTrue(viewMock.didCallShowPaginationError)
        XCTAssertEqual(viewMock.showPaginationErrordescription, descriptionError)
        
    }
    
    func testDidGetCharacterListPaginationConnectionError() {
        // Given
        let error: CharacterListError = .paginationError
        let descriptionError = CharacterListError.paginationError.description
        // When
        sut.didGetCharacterListError(error: error)
        // Then
        XCTAssertTrue(viewMock.didCallShowPaginationError)
        XCTAssertEqual(viewMock.showPaginationErrordescription, descriptionError)
    }
    
    func testScrollViewDidReachEndWhenNOTLoadingMoreCharacters() {
        // Given
        // When
        self.sut.scrollViewDidReachEnd()
        // Then
        XCTAssertTrue(viewMock.didDisplayFooterLoader)
        XCTAssertTrue(interactorMock.didCallGetNextCharacters)

    }
    
    func testScrollViewDidReachEndWhenLoadingMoreCharacters() {
        // Given
            // The loadingMoreCharacters will be toggled to 'True'
        self.sut.viewDidLoad()
        // When
        self.sut.scrollViewDidReachEnd()
        // Then
        XCTAssertFalse(viewMock.didDisplayFooterLoader)
        XCTAssertFalse(interactorMock.didCallGetNextCharacters)
    
    }
}

// MARK: - Mock Classes
private class MockCharacterListRouterToPresenter {
    var didGoToCharacterDetail = false
}

extension MockCharacterListRouterToPresenter: CharacterListRouterDelegate {
    func goToCharacterDetail(characterId: Int) {
        didGoToCharacterDetail = true
    }
}

private class MockCharacterListInteractorToPresenter {
    // MARK: getInitialCharacterList
    var didCallGetInitialCharacterList: Bool = false
    
    // MARK: getNextCharacters
    var didCallGetNextCharacters: Bool = false

}

extension MockCharacterListInteractorToPresenter: CharacterListInteractorDelegate {
    func getInitialCharacterList(name: String?) {
        didCallGetInitialCharacterList = true
    }
    
    func getNextCharacters(offset: Int, name: String?) {
        didCallGetNextCharacters = true
    }
    
}

private class MockCharacterListViewToPresenter {
    
    // MARK: displayInitialCharacterList
    var didDisplayInitialCharacterList = false
    
    // MARK: displatNextCharacterList
    var didDisplayNextCharacterList = false
    
    // MARK: showError
    var didCallShowMessage: Bool = false
    var showErrorTitle = ""
    var showErrordescription = ""
    var showErrorIcon: UIImage = UIImage()
    
    // MARK: showPaginationMessage
    var didCallShowPaginationError: Bool = false
    var showPaginationErrordescription = ""
    
    // MARK: displayFooterLoader
    var didDisplayFooterLoader = false
    
}

extension MockCharacterListViewToPresenter: CharacterListViewControllerDelegate {
    func displayInitialCharacterList(characterList: CharacterListViewModel) {
        didDisplayInitialCharacterList = true
    }
    
    func displayNextCharacterList(characterList: CharacterListViewModel) {
        didDisplayNextCharacterList = true
    }
    
    func showMessage(title: String, description: String, icon: UIImage) {
        didCallShowMessage = true
        showErrorTitle = title
        showErrordescription = description
        showErrorIcon = icon
    }
    
    func showPaginationMessage(description: String) {
        didCallShowPaginationError = true
        showPaginationErrordescription = description
    }
    
    func displayFooterLoader() {
        didDisplayFooterLoader = true
    }
    
}
