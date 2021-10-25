//
//  UIScreenBase.swift
//  MarvelApplicationTests
//
//  Created by K3V1NS4N on 25/10/21.
//

import Foundation
import XCTest

class UIScreenBase: XCBase {
    
}

extension UIScreenBase {
    static let app = XCUIApplication()
    static let otherElements = app.otherElements
    static let staticTexts = app.staticTexts
    static let buttons = app.buttons
    static let navBars = app.navigationBars
    static let collectionView = app.collectionViews.firstMatch
    
}
