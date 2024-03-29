//
//  App1UITests.swift
//  App1UITests
//
//  Created by Viktor Kirillov on 11/18/19.
//  Copyright © 2019 Viktor Kirillov. All rights reserved.
//

import XCTest

class App1UITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // UI tests must launch the application that they test.

        // Use recording to get started writing UI tests.
        
        let app = XCUIApplication()
        app.launch()
        app.buttons["Click me"].tap()
        
        let screenshot = XCUIApplication().screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        attachment.lifetime = .keepAlways
        attachment.name = "OpeningScreen"
        self.add(attachment)
        
        app.alerts["Hey"].scrollViews.otherElements.buttons["Ok"].tap()
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
