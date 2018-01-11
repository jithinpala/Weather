//
//  JBStringExtension.swift
//  Weather
//
//  Created by Jithin on 11/1/18.
//  Copyright © 2018 Jithinpala. All rights reserved.
//

import XCTest
@testable import Weather

class JBStringExtension: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCapitalizeOfString() {
        let result = "this text".capitalizingFirstLetter()
        XCTAssert(result == "This text", "Method not working")
    }    
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
