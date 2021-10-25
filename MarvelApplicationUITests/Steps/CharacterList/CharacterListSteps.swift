//
//  CharacterListSteps.swift
//  MarvelApplicationTests
//
//  Created by K3V1NS4N on 25/10/21.
//

import Foundation
import XCTest

extension UITestBase {

    func whenTapOnSearchBar() {
        CharacterListScreen.searchDescription.tap()
    }
    
    func whenTapOnCancelButton() {
        CharacterListScreen.searchCancelButton.tap()
    }
    
    func whenTapOnCharacterCell() {
        CharacterListScreen.secondCell.tap()
    }
    
    func whenTapFilterIcon() {
        
    }
    
    func whenTapOnCancelActionSheetButton() {
        
    }
    
    func whenScrollDownOnCharacters() {
        CharacterListScreen.characters.swipeUp()
    }

    func thenScreenTitleDisplayed() {
        XCTAssertTrue(CharacterListScreen.screenTitle.waitForExistence(timeout: Constants.waitForViewControllerAppear))
    }
    func thenSearchBarDisplayed() {
        XCTAssertTrue(CharacterListScreen.searchDescription.waitForExistence(timeout: Constants.waitForViewControllerAppear))
    }
    
    func thenCollectionViewDisplayed() {
        XCTAssertTrue(CharacterListScreen.characters.waitForExistence(timeout: Constants.waitForViewControllerAppear))
    }
    
    func thenFilterOptionsDisplayed() {
        
    }
    
    func thenAbsorbingManCellNumber25Displayed() {
        XCTAssertTrue(CharacterListScreen.absorbingManCell.isHittable)
    }
    
}
