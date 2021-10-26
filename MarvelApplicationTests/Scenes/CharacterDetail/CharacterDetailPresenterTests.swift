//
//  CharacterDetailPresenterTests.swift
//  MarvelApplicationTests
//
//  Created by K3V1NS4N on 25/10/21.
//

import Foundation
import XCTest

@testable import MarvelApplication

class CharacterDetailPresenterTests: XCTestCase {
    private var sut: CharacterDetailPresenter!

    // MARK: - Test Objects
    private var interactorMock: MockCharacterDetailInteractorToPresenter!
    private var viewMock: MockCharacterDetailViewToPresenter!
    private var routerMock: MockCharacterDetailRouterToPresenter!
    
    private var characterId: Int = 6456456 // 3-D Man ID
    
    override func setUp() {
        super.setUp()

        let router = MockCharacterDetailRouterToPresenter()
        self.routerMock = router
        let interactor = MockCharacterDetailInteractorToPresenter()
        self.interactorMock =  interactor
        let view = MockCharacterDetailViewToPresenter()
        self.viewMock = view

        sut = CharacterDetailPresenter(interface: view, interactor: interactor, router: router, characterId: characterId)
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
        XCTAssertTrue(interactorMock.didGetCharacterDetail)
    }
    
    func testDidGetCharacterDetail() {
        // Given
        let model = CharacterDetailModelTest().fillCase()
        // When
        self.sut.didGetCharacterDetail(characterDetail: model)
        // Then
        XCTAssertTrue(viewMock.didDisplayCharacter)
        
    }
    
    func testDidGetNilCharacterDetail() {
        // Given
        let model = CharacterDetailModelTest().nilCase()
        let titleError = CharacterDetailError.genericError(.genericServerError).title
        let descriptionError = CharacterDetailError.genericError(.genericServerError).description
        let iconError: UIImage = .serverErrorIcon
        // When
        self.sut.didGetCharacterDetail(characterDetail: model)
        // Then
        XCTAssertFalse(viewMock.didDisplayCharacter)
        XCTAssertEqual(viewMock.showErrorTitle, titleError)
        XCTAssertEqual(viewMock.showErrordescription, descriptionError)
        XCTAssertEqual(viewMock.showErrorIcon, iconError)
        
    }
    
    func testDidGetCharacterDetailServerError() {
        // Given
        let error: CharacterDetailError = .genericError(.genericServerError)
        let titleError = CharacterDetailError.genericError(.genericServerError).title
        let descriptionError = CharacterDetailError.genericError(.genericServerError).description
        let iconError: UIImage = .serverErrorIcon
        // When
        sut.didGetCharacterDetailError(error: error)
        // Then
        XCTAssertTrue(viewMock.didCallShowError)
        XCTAssertEqual(viewMock.showErrorTitle, titleError)
        XCTAssertEqual(viewMock.showErrordescription, descriptionError)
        XCTAssertEqual(viewMock.showErrorIcon, iconError)
        
    }
    
    func testDidGetCharacterDetailConnectionError() {
        // Given
        let error: CharacterDetailError = .connection(.notReachable)
        let titleError = CharacterDetailError.connection(.notReachable).title
        let descriptionError = CharacterDetailError.connection(.notReachable).description
        let iconError: UIImage = .connectionErrorIcon
        // When
        sut.didGetCharacterDetailError(error: error)
        // Then
        XCTAssertTrue(viewMock.didCallShowError)
        XCTAssertEqual(viewMock.showErrorTitle, titleError)
        XCTAssertEqual(viewMock.showErrordescription, descriptionError)
        XCTAssertEqual(viewMock.showErrorIcon, iconError)
        
    }

}

// MARK: - Mock Classes
private class MockCharacterDetailRouterToPresenter {
    
}

extension MockCharacterDetailRouterToPresenter: CharacterDetailRouterProtocol {

}

private class MockCharacterDetailInteractorToPresenter {
    var didGetCharacterDetail = false
}

extension MockCharacterDetailInteractorToPresenter: CharacterDetailInteractorProtocol {
    func getCharacterDetail(characterId: Int) {
        didGetCharacterDetail = true
    }
    
}

private class MockCharacterDetailViewToPresenter {
    
    // MARK: displayCharacter
    var didDisplayCharacter = false
    
    // MARK: showError
    var didCallShowError: Bool = false
    var showErrorTitle = ""
    var showErrordescription = ""
    var showErrorIcon: UIImage = UIImage()
    
}

extension MockCharacterDetailViewToPresenter: CharacterDetailViewControllerProtocol {
    func displayCharacter(model: CharacterDetailViewModel) {
        didDisplayCharacter = true
    }
    
    func showError(title: String, description: String, icon: UIImage) {
        didCallShowError = true
        showErrorTitle = title
        showErrordescription = description
        showErrorIcon = icon
    }
}
