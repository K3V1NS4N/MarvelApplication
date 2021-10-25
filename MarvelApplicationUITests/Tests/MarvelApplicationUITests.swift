//
//  MarvelApplicationUITests.swift
//  MarvelApplicationUITests
//
//  Created by K3V1NS4N on 25/10/21.
//

import XCTest

class MarvelApplicationUITests: UITestBase {
    
    func testInitialLoad() {
        // When initial character list screen is loaded
        thenScreenTitleDisplayed()
        thenSearchBarDisplayed()
        thenCollectionViewDisplayed()
    }
    
    func testNavigateToDetail() {
        whenTapOnCharacterCell()

    }
    
    func testScrollDownPagination() {
        whenScrollDownOnCharacters()
        whenScrollDownOnCharacters()
        whenScrollDownOnCharacters()
        thenAbsorbingManCellNumber25Displayed()
    }
    
    func testPerformSearch() {
        whenTapOnSearchBar()
        whenTapOnCancelButton()
        thenCollectionViewDisplayed()
    }
    
}
