//
//  CharacterDetailSteps.swift
//  MarvelApplicationTests
//
//  Created by K3V1NS4N on 25/10/21.
//

import Foundation
import XCTest

extension UITestBase {
    
    func thenCharacterNameDisplayed() {
        XCTAssertTrue(CharacterDetailScreen.bombCharacterName.waitForExistence(timeout: Constants.waitForViewControllerAppear))
    }
    
}
