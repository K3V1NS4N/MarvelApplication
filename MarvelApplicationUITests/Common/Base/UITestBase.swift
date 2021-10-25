//
//  UITestBase.swift
//  MarvelApplicationTests
//
//  Created by K3V1NS4N on 25/10/21.
//

import Foundation
import XCTest

class UITestBase: XCBase {
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        app.terminate()
        app = nil
        super.tearDown()
    }

}
