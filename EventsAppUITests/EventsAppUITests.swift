//
//  EventsAppUITests.swift
//  EventsAppUITests
//
//  Created by Hariel Giacomuzzi on 27/07/19.
//  Copyright © 2019 Giacomuzzi. All rights reserved.
//

import XCTest

class EventsAppUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false

        XCUIApplication().launch()
    }

    override func tearDown() {
    }

    func testExample() {
        let app = XCUIApplication()
        app.launch()

        let event = app.scrollViews.otherElements.staticTexts["DOAÇÃO DE ROUPAS"]
        let exists = NSPredicate(format: "exists == 1")

        expectation(for: exists, evaluatedWith: event, handler: nil)
        waitForExpectations(timeout: 20.0, handler: nil)
    }

}
