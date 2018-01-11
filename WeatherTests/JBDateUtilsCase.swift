//
//  JBDateUtilsCase.swift
//  Weather
//
//  Created by Jithin on 11/1/18.
//  Copyright © 2018 Jithinpala. All rights reserved.
//

import XCTest
@testable import Weather

class JBDateUtilsCase: XCTestCase {    
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMillisecondConvertion() {
        let timeValue = DateUtils.sharedInstane.convertWeatherTimeDate(milliSeonds: 1515610999)
        XCTAssert(timeValue == "6:03")
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
