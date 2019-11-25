//
//  App1Tests.swift
//  App1Tests
//
//  Created by Viktor Kirillov on 11/18/19.
//  Copyright © 2019 Viktor Kirillov. All rights reserved.
//

import XCTest

@testable import App1

class App1Tests: XCTestCase {
    
    var viewController = ViewController()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDogMyCats() {
        let input = "cats"
        let output = "dogs"
        XCTAssertEqual(output, self.viewController.dogMyCats(input), "Failed to produce \(output) from \(input)")
    }
    

//    func testExample() {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
