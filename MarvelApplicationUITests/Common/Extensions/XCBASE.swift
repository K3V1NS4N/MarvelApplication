import XCTest

@available(OSX 10.11, *)
open class XCBase: XCTestCase {

    var app: XCUIApplication!

    open func waitUntilElementActive(element: XCUIElement) {
        let exists = NSPredicate(format: "exists == true AND hittable == true AND enabled == true")
        expectation(for: exists, evaluatedWith: element, handler: nil)
        waitForExpectations(timeout: 60, handler: nil)
        XCTAssert(element.exists)
    }

    open func waitForElementToAppearCommpleted(_ element: XCUIElement) -> Bool {
        let predicate = NSPredicate(format: "exists == true AND hittable == true AND enabled == true")
        let xcfitExpectation = expectation(for: predicate, evaluatedWith: element,
                                           handler: nil)

        let result = XCTWaiter().wait(for: [xcfitExpectation], timeout: 60)
        return result == .completed
    }

    open func waitForElementToAppearTimedOut(_ element: XCUIElement) -> Bool {
        let predicate = NSPredicate(format: "exists == true AND hittable == true AND enabled == true")
        let xcfitExpectation = expectation(for: predicate, evaluatedWith: element,
                                           handler: nil)
        let result = XCTWaiter().wait(for: [xcfitExpectation], timeout: 60)
        return result == .timedOut
    }

    open func waitForElementToAppearIncorrectOrder(_ element: XCUIElement) -> Bool {
        let predicate = NSPredicate(format: "exists == true AND hittable == true AND enabled == true")
        let xcfitExpectation = expectation(for: predicate, evaluatedWith: element,
                                           handler: nil)
        let result = XCTWaiter().wait(for: [xcfitExpectation], timeout: 60)
        return result == .incorrectOrder
    }

    open func waitForElementToAppearinvertedFulfillment(_ element: XCUIElement) -> Bool {
        let predicate = NSPredicate(format: "exists == true AND hittable == true AND enabled == true")
        let xcfitExpectation = expectation(for: predicate, evaluatedWith: element,
                                           handler: nil)
        let result = XCTWaiter().wait(for: [xcfitExpectation], timeout: 60)
        return result == .invertedFulfillment
    }

    open func elementAppeared(_ element: XCUIElement) {
        let result = waitForElementToAppearCommpleted(element)
        XCTAssertTrue(result)
//        waitUntilElementActive(element: element)
    }

    open func elementByLabel(_ label: String, type: String) -> XCUIElement {
        let application = XCUIApplication()
        var elementQuery: XCUIElementQuery!
        switch type {
        case "button":
            elementQuery = application.buttons
        case "label":
            elementQuery = application.staticTexts
        case "tab":
            elementQuery = application.tabs
        case "field", "text field":
            elementQuery = application.textFields
        case "textView", "text view":
            elementQuery = application.textViews
        case "view":
            elementQuery = application.otherElements
        default: elementQuery = application.otherElements
        }
        return elementQuery[label]
    }
}
